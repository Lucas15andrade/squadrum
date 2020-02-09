import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:squadrum/app/shared/models/squad_model.dart';

class UsuarioModel {
  FirebaseUser firebaseUser;
  bool carregando = true;
  List<SquadModel> squads;
  String email;
  String nome;
  String sobrenome;
  String nickname;
  String id;
  String urlImagem;
  String cargo;
  String bio;

  UsuarioModel(
      {this.firebaseUser,
      this.carregando,
      this.squads,
      this.email,
      this.nome,
      this.sobrenome,
      this.nickname,
      this.urlImagem,
      this.cargo,
      this.bio});

  UsuarioModel.fromDocument(DocumentSnapshot doc) {
    id = doc.documentID;
    email = doc["email"];
    nome = doc["nome"];
    sobrenome = doc["sobrenome"];
    nickname = doc["nickname"];
    urlImagem = doc["urlImagem"];
    cargo = doc["cargo"];
    bio = doc["bio"];
  }
}
