  import 'package:squadrum/app/modules/home/resumo/squad/membro/membro_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:squadrum/app/modules/home/resumo/squad/squad_page.dart';

class SquadModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [Bloc((i) => MembroBloc()),];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => SquadPage();

  static Inject get to => Inject<SquadModule>.of();
}
