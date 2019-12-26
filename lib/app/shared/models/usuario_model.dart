import 'package:firebase_auth/firebase_auth.dart';

class UsuarioModel {
  FirebaseUser firebaseUser;
  bool carregando = true;
  List<dynamic> squads;

  UsuarioModel({this.firebaseUser, this.carregando, this.squads});
}