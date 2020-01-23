import 'package:squadrum/app/modules/home/resumo/squad/squad_bloc.dart';
import 'package:squadrum/app/modules/home/resumo/resumo_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:squadrum/app/modules/home/resumo/resumo_page.dart';

class ResumoModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => SquadBloc()),
        Bloc((i) => ResumoBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => ResumoPage();

  static Inject get to => Inject<ResumoModule>.of();
}
