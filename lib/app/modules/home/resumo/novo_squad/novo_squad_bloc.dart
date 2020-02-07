import 'dart:async';
import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/subjects.dart';
import 'package:squadrum/app/services/firebase_service.dart';
import 'package:squadrum/app/shared/enums/status.dart';
import 'package:squadrum/app/shared/models/squad_model.dart';

class NovoSquadBloc extends BlocBase {
  //bool sucesso;

  BehaviorSubject<Status> _sucessoController = BehaviorSubject.seeded(Status.VAZIO);

  Stream get sucessoOut => _sucessoController.stream;
  Sink get sucessoIn => _sucessoController.sink;

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _sucessoController.close();
    super.dispose();
  }

  adicionarSquad(SquadModel squad, File file) async {
    sucessoIn.add(Status.CARREGANDO);
    String idSquad = await FirebaseService.salvarSquad(squad, file);
    if (idSquad.isNotEmpty) {
      sucessoIn.add(Status.SUCESSO);
    } else {
      sucessoIn.add(Status.ERRO);
    }
  }
}
