  import 'package:squadrum/app/modules/autenticacao/login_email/login_email_bloc.dart';
  import 'package:bloc_pattern/bloc_pattern.dart';
  import 'package:flutter/material.dart';
import 'package:squadrum/app/modules/autenticacao/autenticacao_page.dart';
  
  class AutenticacaoModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [Bloc((i) => LoginEmailBloc()),];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => AutenticacaoPage();

  static Inject get to => Inject<AutenticacaoModule>.of();

}
  