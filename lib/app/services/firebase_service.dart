import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:squadrum/app/app_bloc.dart';
import 'package:squadrum/app/app_module.dart';
import 'package:squadrum/app/modules/home/resumo/resumo_module.dart';
import 'package:squadrum/app/shared/models/squad_model.dart';
import 'package:squadrum/app/shared/models/usuario_model.dart';
import 'package:squadrum/app/modules/home/resumo/squad/squad_bloc.dart';

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
        .setData({
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
      if(sm.id == squad.id){
        return true;
      }
    }
    return false;
  }

  static Future<List<SquadModel>> carregaSquads(List<dynamic> squads) async {
    List<String> idSquads = squads.map((s) {
      print(s.toString());
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

  static Future<String> pesquisaNickname(String nickname) async{
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
}
