import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:squadrum/app/modules/home/resumo/squad/evento/evento_bloc.dart';
import 'package:squadrum/app/modules/home/resumo/squad/evento/evento_page.dart';

class EventoModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => EventoBloc()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => EventoPage();

  static Inject get to => Inject<EventoModule>.of();
}
