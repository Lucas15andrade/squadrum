import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:squadrum/app/modules/home/resumo/novo_squad/novo_squad_bloc.dart';
import 'package:squadrum/app/modules/home/resumo/novo_squad/novo_squad_page.dart';

class NovoSquadModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => NovoSquadBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => NovoSquadPage();

  static Inject get to => Inject<NovoSquadModule>.of();
}
