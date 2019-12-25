import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/subjects.dart';

class RegistroEmailBloc extends BlocBase {
  BehaviorSubject<bool> _registroEmailController = BehaviorSubject();

  Stream get registroEmailOut => _registroEmailController.stream;
  Sink get registroEmailIn => _registroEmailController.sink;
  FirebaseUser firebaseUser;

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _registroEmailController.close();
    super.dispose();
  }

  void pesquisaNickname(String nickname) {
    Firestore.instance
        .collection('nicknames')
        .document(nickname)
        .get()
        .then((DocumentSnapshot ds) {
      if (ds.data != null) {
        registroEmailIn.add(true);
      } else {
        registroEmailIn.add(false);
      }
    });
  }
}
