import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:squadrum/app/app_bloc.dart';
import 'package:squadrum/app/app_module.dart';
import 'package:squadrum/app/modules/home/resumo/resumo_module.dart';
import 'package:squadrum/app/modules/home/resumo/squad/squad_bloc.dart';
import 'package:squadrum/app/shared/models/squad_model.dart';
import 'package:squadrum/app/shared/models/usuario_model.dart';

import 'image_service.dart';

class FirebaseService {
  static Future<Null> saveUserData(
      {@required Map<String, dynamic> userData,
      @required FirebaseUser firebaseUser}) async {
    await Firestore.instance
        .collection("usuarios")
        .document(firebaseUser.uid)
        .setData(userData);

    await Firestore.instance
        .collection("usuarios")
        .document(firebaseUser.uid)
        .updateData({
      "urlImagem":
          "https://firebasestorage.googleapis.com/v0/b/squadrum-1d648.appspot.com/o/boy.png?alt=media&token=c80e3c2d-1f5c-4a82-bde4-30b91709bcce"
    });

    await Firestore.instance
        .collection("nicknames")
        .document(userData["nickname"])
        .setData({"uid": firebaseUser.uid});

    AppModule.to.bloc<AppBloc>().userData = userData;
  }

  static Future<bool> verificaUsuarioJaAdicionado(UsuarioModel usuario) async {
    SquadModel squad = ResumoModule.to.bloc<SquadBloc>().squad;

    for (SquadModel sm in usuario.squads) {
      if (sm.id == squad.id) {
        return true;
      }
    }
    return false;
  }

  static Future<List<SquadModel>> carregaSquads(List<dynamic> squads) async {
    List<String> idSquads = squads.map((s) {
      return s.toString().trim();
    }).toList();

    List<SquadModel> listaSquads = List();

    for (String s in idSquads) {
      DocumentSnapshot docUser = await Firestore.instance
          .collection("squads")
          .document(s.toString().trim())
          .get();

      SquadModel squad = SquadModel.fromDocument(docUser);

      if (squad.membros != null) {
        for (String idMembro in squad.membros) {
          DocumentSnapshot doc = await Firestore.instance
              .collection("usuarios")
              .document(idMembro.toString().trim())
              .get();
          UsuarioModel usuario = UsuarioModel.fromDocument(doc);
          squad.listaUsuarios.add(usuario);
        }
      }

      listaSquads.add(squad);
    }

    return listaSquads;
  }

  static Future<String> pesquisaNickname(String nickname) async {
    String uid;
    await Firestore.instance
        .collection("nicknames")
        .document(nickname)
        .get()
        .then((DocumentSnapshot ds) {
      if (ds.data != null) {
        uid = ds.data["uid"];
      }
    });

    return uid;
  }

  static Future<Null> adicionarMembro(UsuarioModel usuario) async {
    SquadModel squad = ResumoModule.to.bloc<SquadBloc>().squad;

    await Firestore.instance
        .collection("squads")
        .document(squad.id)
        .updateData({
      "membros": FieldValue.arrayUnion([usuario.id])
    });

    await Firestore.instance
        .collection("usuarios")
        .document(usuario.id)
        .updateData({
      "squads": FieldValue.arrayUnion([squad.id])
    });

    await AppModule.to.getBloc<AppBloc>().carregaApenasSquads();

    UsuarioModel usuarioModel = AppModule.to.getBloc<AppBloc>().usuario;

    var lista = usuarioModel.squads.where((s) {
      if (s.id == squad.id) {
        return true;
      } else {
        return false;
      }
    }).toList();

    ResumoModule.to.getBloc<SquadBloc>().adicionaSquad(lista.first);
  }

  static Future<Null> removeMembro(UsuarioModel usuario) async {
    SquadModel squad = ResumoModule.to.bloc<SquadBloc>().squad;

    await Firestore.instance
        .collection("squads")
        .document(squad.id)
        .updateData({
      "membros": FieldValue.arrayRemove([usuario.id])
    });

    await Firestore.instance
        .collection("usuarios")
        .document(usuario.id)
        .updateData({
      "squads": FieldValue.arrayRemove([squad.id])
    });

    await AppModule.to.getBloc<AppBloc>().carregaApenasSquads();

    UsuarioModel usuarioModel = AppModule.to.getBloc<AppBloc>().usuario;

    var lista = usuarioModel.squads.where((s) {
      if (s.id == squad.id) {
        return true;
      } else {
        return false;
      }
    }).toList();

    ResumoModule.to.getBloc<SquadBloc>().adicionaSquad(lista.first);
  }

  static Future<Null> atualizaLogoSquad(SquadModel squad) async {
    SquadBloc squadBloc = ResumoModule.to.getBloc<SquadBloc>();
    File file = await ImagePicker.pickImage(source: ImageSource.gallery);

    File image = await ImageService.comprimirImagem(file);

    if (image == null) return null;

    StorageUploadTask task =
        FirebaseStorage.instance.ref().child(squad.id).putFile(image);
    StorageTaskSnapshot taskSnapshot = await task.onComplete;
    String url = await taskSnapshot.ref.getDownloadURL();

    await Firestore.instance
        .collection("squads")
        .document(squad.id)
        .updateData({"urlImagem": url});

    squad.urlImagem = url;
    squadBloc.adicionaSquad(squad);

    AppModule.to.getBloc<AppBloc>().loadCurrentUser();
  }

  static Future<String> salvarSquad(SquadModel squad, File file) async {
    String idSquad;

    await Firestore.instance.collection("squads").add({
      "titulo": squad.titulo,
      "descricao": squad.descricao,
      "membros": FieldValue.arrayUnion([squad.membros.first]),
      "urlImagem":
          "https://firebasestorage.googleapis.com/v0/b/squadrum-1d648.appspot.com/o/logo.png?alt=media&token=31ba7a2e-0eaf-4dd6-8406-ecac3a00733b"
    }).then((doc) async {
      idSquad = doc.documentID;
    });

    await Firestore.instance
        .collection("usuarios")
        .document(squad.membros.first)
        .updateData({
      "squads": FieldValue.arrayUnion([idSquad])
    });

    if (idSquad.isNotEmpty) {
      if (file != null) {
        File image = await ImageService.comprimirImagem(file);

        if (image == null) return null;

        StorageUploadTask task =
            FirebaseStorage.instance.ref().child(idSquad).putFile(image);
        StorageTaskSnapshot taskSnapshot = await task.onComplete;
        String url = await taskSnapshot.ref.getDownloadURL();

        await Firestore.instance
            .collection("squads")
            .document(idSquad)
            .updateData({"urlImagem": url});
      }
    }
    await AppModule.to.getBloc<AppBloc>().carregaApenasSquads();
    return idSquad;
  }
}
