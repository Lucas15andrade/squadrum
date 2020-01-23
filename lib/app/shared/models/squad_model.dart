import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:squadrum/app/shared/models/usuario_model.dart';

class SquadModel {
  String id;
  String titulo;
  String descricao;
  String urlImagem;
  List<dynamic> membros;
  List<UsuarioModel> listaUsuarios = List();

  SquadModel(
      {this.id, this.titulo, this.descricao, this.urlImagem, this.membros, this.listaUsuarios});

  SquadModel.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    titulo = document.data["titulo"];
    descricao = document.data["descricao"];
    urlImagem = document.data["urlImagem"];
    membros = document.data["membros"];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "titulo": titulo,
      "descricao": descricao,
      "urlImagem": urlImagem,
      "membros": membros
    };
  }
}
