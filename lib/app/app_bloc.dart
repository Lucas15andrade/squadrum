import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class AppBloc extends BlocBase {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();

  BehaviorSubject<FirebaseUser> _userController = BehaviorSubject();
  Stream get userOut => _userController.stream;

  Sink get userIn => _userController.sink;

  //dispose will be called automatically by closing its streams

  AppBloc() {
    print("Dentro do app bloc");
    //signIn(email: "lap.andrade15@gmail.com", pass: "123456");
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
        .then((user) async {
      firebaseUser = user as FirebaseUser;

      await _saveUserData(userData);

      userIn.add(user);

      onSuccess();
    }).catchError((e) {
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
      //firebaseUser = user as FirebaseUser;
      //await _loadCurrentUser();

      userIn.add(auth.user);
      print(auth.user.email);
      onSuccess();
    }).catchError((e) {
      onFail();
      print(e);
    });
  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance
        .collection("users")
        .document(firebaseUser.uid)
        .setData(userData);
  }

  Future<Null> _loadCurrentUser() async {
    if (firebaseUser == null) {
      firebaseUser = await _auth.currentUser();
    }
    if (firebaseUser != null) {
      if (userData["name"] == null) {
        DocumentSnapshot docUser = await Firestore.instance
            .collection("users")
            .document(firebaseUser.uid)
            .get();
        userData = docUser.data;
      }
    }
  }
}
