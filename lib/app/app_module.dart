  import 'package:squadrum/app/modules/autenticacao/autenticacao_bloc.dart';
  import 'package:squadrum/app/app_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:squadrum/app/app_widget.dart';

class AppModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [Bloc((i) => AutenticacaoBloc()),Bloc((i) => AppBloc()),];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();

}
  