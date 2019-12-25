import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:squadrum/app/shared/models/usuario_model.dart';

class AppBloc extends BlocBase {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();
  UsuarioModel usuario = UsuarioModel();

  BehaviorSubject<UsuarioModel> _userController = BehaviorSubject();
  Stream get userOut => _userController.stream;

  Sink get userIn => _userController.sink;

  //dispose will be called automatically by closing its streams
  AppBloc() {
    _loadCurrentUser();
  }

  @override
  void dispose() {
    _userController.close();
    super.dispose();
  }

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
      userIn.add(usuario);
      await _saveUserData(userData);

      onSuccess();
      usuario.carregando = false;
      userIn.add(usuario);
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
      userIn.add(usuario);
      await _loadCurrentUser();
      onSuccess();
      await Future.delayed(Duration(seconds: 2));
      usuario.carregando = false;
      userIn.add(usuario);
    }).catchError((e) {
      onFail();
      print(e);
    });
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance
        .collection("usuarios")
        .document(firebaseUser.uid)
        .setData(userData);

    await Firestore.instance
        .collection("nicknames")
        .document(userData["nickname"])
        .setData({"uid": firebaseUser.uid});
  }

  void recoverPass(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  Future<Null> _loadCurrentUser() async {
    if (firebaseUser == null) {
      firebaseUser = await _auth.currentUser();
      usuario.firebaseUser = firebaseUser;
      userIn.add(usuario);
    }
    if (firebaseUser != null) {
      if (userData["nome"] == null) {
        DocumentSnapshot docUser = await Firestore.instance
            .collection("usuarios")
            .document(firebaseUser.uid)
            .get();
        userData = docUser.data;
      }
    }
  }

  void signOut() async {
    await _auth.signOut();
    userData = Map();
    usuario.firebaseUser = null;
    userIn.add(usuario);
  }
}
