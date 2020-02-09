import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:squadrum/app/app_bloc.dart';
import 'package:squadrum/app/app_module.dart';
import 'package:squadrum/app/services/firebase_service.dart';
import 'package:squadrum/app/shared/models/usuario_model.dart';
import 'package:flutter/material.dart';

class AutenticacaoBloc extends BlocBase {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  UsuarioModel usuario = UsuarioModel();

  void signUp(
      {@required Map<String, dynamic> userData,
      @required String pass,
      VoidCallback onSuccess,
      VoidCallback onFail}) {
    _auth
        .createUserWithEmailAndPassword(
            email: userData["email"], password: pass)
        .then((auth) async {
      firebaseUser = auth.user;
      usuario.firebaseUser = firebaseUser;
      usuario.carregando = true;

      FirebaseService.saveUserData(
          userData: userData, firebaseUser: firebaseUser);

      AppModule.to.bloc<AppBloc>().adicionarUsuario(usuario);
      AppModule.to.bloc<AppBloc>().loadCurrentUser();
      onSuccess();
    }).catchError((e) {
      print(e);
      onFail();
    });
  }

  void signIn(
      {@required String email,
      @required String pass,
      @required onSuccess,
      @required onFail}) async {
    _auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((auth) async {
      firebaseUser = auth.user;
      usuario.firebaseUser = firebaseUser;
      usuario.carregando = true;
      AppModule.to.bloc<AppBloc>().adicionarUsuario(usuario);
      AppModule.to.bloc<AppBloc>().loadCurrentUser();
      onSuccess();
    }).catchError((e) {
      onFail();
      print(e);
    });
  }

/*   void signOut() async {
    await _auth.signOut();
    usuario.firebaseUser = null;
    firebaseUser = null;
    usuario = UsuarioModel();
    AppModule.to.bloc<AppBloc>().adicionarUsuario(usuario);
  } */

  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    super.dispose();
  }
}
