import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:squadrum/app/modules/home/home_module.dart';
import 'package:squadrum/app/modules/home/resumo/resumo_bloc.dart';
import 'package:squadrum/app/shared/models/squad_model.dart';
import 'package:squadrum/app/shared/models/usuario_model.dart';

class AppBloc extends BlocBase {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();
  UsuarioModel usuario = UsuarioModel();
  List<SquadModel> squads = List();

  BehaviorSubject<UsuarioModel> _userController =
      BehaviorSubject.seeded(UsuarioModel());

  Stream get userOut => _userController.stream;
  Sink get userIn => _userController.sink;

  BehaviorSubject<List<SquadModel>> _squadController = BehaviorSubject();

  Stream get squadOut => _squadController.stream;
  Sink get squadIn => _squadController.sink;

  //TESTE INTERNET

  StreamController<ConnectivityResult> _connectivityController = StreamController();

  Stream get conOut => _connectivityController.stream;
  Sink get conIn => _connectivityController.sink;

  StreamSubscription<ConnectivityResult> _subscription;

  StreamSubscription get subsOut => _subscription;

  //dispose will be called automatically by closing its streams
  AppBloc() {
    loadCurrentUser();
    verificaInternet();
  }

  @override
  void dispose() {
    _userController.close();
    _squadController.close();
    _connectivityController.close();
    _subscription.cancel();
    super.dispose();
  }

//TODO Remover
/*   Future<Null> saveUserData(Map<String, dynamic> userData, FirebaseUser fUser) async {
    this.userData = userData;
    await Firestore.instance
        .collection("usuarios")
        .document(firebaseUser.uid)
        .setData(userData);

    await Firestore.instance
        .collection("nicknames")
        .document(userData["nickname"])
        .setData({"uid": firebaseUser.uid});
  } */

  Future<Null> verificaInternet() async {
    conIn.add(await Connectivity().checkConnectivity());

    _subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      conIn.add(result);
    });

  }

  Future<Null> loadCurrentUser() async {
    if (firebaseUser == null) {
      firebaseUser = await _auth.currentUser();
    }
    if (firebaseUser != null) {
      if (userData["nome"] == null) {
        DocumentSnapshot docUser = await Firestore.instance
            .collection("usuarios")
            .document(firebaseUser.uid)
            .get();
        userData = docUser.data;
        usuario.firebaseUser = firebaseUser;
        usuario.squads = await carregaSquads(docUser.data["squads"]);
        userIn.add(usuario);
        squadIn.add(usuario.squads);
      }
    }
  }

  void signOut() async {
    await _auth.signOut();
    userData = Map();
    usuario.firebaseUser = null;
    userIn.add(usuario);
  }

  Future<List<SquadModel>> carregaSquads(List<dynamic> squads) async {
    List<String> idSquads = squads.map((s) {
      print(s.toString());
      return s.toString().trim();
    }).toList();

    List<SquadModel> listaSquads = List();

    for (String s in idSquads) {
      DocumentSnapshot docUser = await Firestore.instance
          .collection("squads")
          .document(s.toString().trim())
          .get();

      SquadModel squad = SquadModel.fromDocument(docUser);

      if (squad.membros != null) {
        for (String idMembro in squad.membros) {
          DocumentSnapshot doc = await Firestore.instance
              .collection("usuarios")
              .document(idMembro.toString().trim())
              .get();
          UsuarioModel usuario = UsuarioModel.fromDocument(doc);
          squad.listaUsuarios.add(usuario);
        }
      }

      listaSquads.add(squad);
    }

    squadIn.add(usuario.squads);
    squads = listaSquads;
    HomeModule.to.bloc<ResumoBloc>().squadIn.add(listaSquads);
    return listaSquads;
  }

  void adicionarUsuario(usuario) {
    userIn.add(usuario);
  }

  void atualizaSquad(SquadModel squad) {
    for (SquadModel s in usuario.squads) {
      if (s.id == squad.id) {
        usuario.squads.remove(s);
        usuario.squads.add(squad);
      }
    }

    squadIn.add(usuario.squads);
  }
}
