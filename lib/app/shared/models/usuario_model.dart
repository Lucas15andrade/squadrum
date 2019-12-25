import 'package:firebase_auth/firebase_auth.dart';

class UsuarioModel {
  FirebaseUser firebaseUser;
  bool carregando = true;

  UsuarioModel({this.firebaseUser, this.carregando});
}