  import 'package:squadrum/app/modules/autenticacao/login_email/recupera_senha/recupera_senha_bloc.dart';
  import 'package:bloc_pattern/bloc_pattern.dart';
  import 'package:flutter/material.dart';
import 'package:squadrum/app/modules/autenticacao/login_email/login_email_page.dart';
  
  class LoginEmailModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [Bloc((i) => RecuperaSenhaBloc()),];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => LoginEmailPage();

  static Inject get to => Inject<LoginEmailModule>.of();

}
  