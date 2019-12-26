import 'package:cloud_firestore/cloud_firestore.dart';

class SquadModel {
  String id;
  String titulo;
  String descricao;
  String urlImagem;

  SquadModel({this.id, this.titulo, this.descricao, this.urlImagem});

  SquadModel.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    titulo = document.data["titulo"];
    descricao = document.data["descricao"];
    urlImagem = document.data["urlImagem"];
  }

  Map<String, dynamic> toMap() {
    return {"titulo": titulo, "descricao": descricao, "urlImagem": urlImagem};
  }
}
