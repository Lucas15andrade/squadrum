import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/subjects.dart';
import 'package:squadrum/app/app_bloc.dart';
import 'package:squadrum/app/app_module.dart';
import 'package:squadrum/app/shared/models/squad_model.dart';

class ResumoBloc extends BlocBase {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Firestore firestore = Firestore.instance;
  FirebaseUser firebaseUser;

  List<SquadModel> listaSquads = List();

  BehaviorSubject<List<SquadModel>> _squadController = BehaviorSubject();
  Stream get squadOut => _squadController.stream;
  Sink get squadIn => _squadController.sink;

  var usuario = AppModule.to.bloc<AppBloc>().usuario;

  ResumoBloc();

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _squadController.close();
    super.dispose();
  }
}
