import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:squadrum/app/shared/models/squad_model.dart';

class UsuarioModel {
  FirebaseUser firebaseUser;
  bool carregando = true;
  List<SquadModel> squads;
  String email;
  String nome;
  String nickname;
  String id;
  String urlImagem;
  String cargo;

  UsuarioModel({this.firebaseUser, this.carregando, this.squads, this.email, this.nome, this.nickname, this.urlImagem, this.cargo});

  UsuarioModel.fromDocument(DocumentSnapshot doc){
    id = doc.documentID;
    email = doc["email"];
    nome = doc["nome"];
    nickname = doc["nickname"];
    urlImagem = doc["urlImagem"];
    cargo = doc["cargo"];
  }
}