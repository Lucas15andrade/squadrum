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

  ResumoBloc() {
    //_carregaSquads();
  }

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _squadController.close();
    super.dispose();
  }

  Future<Null> _carregaSquads() async {
   /* var listaSquads;

    List<String> idSquads = usuario.squads.map((s) {
      return s.toString().trim();
    }).toList();

    for (String s in idSquads) {
      DocumentSnapshot docUser = await Firestore.instance
          .collection("squads")
          .document(s.toString().trim())
          .get();

      listaSquads.add(SquadModel.fromDocument(docUser));
    }

    squadIn.add(listaSquads);*/
  }
}
