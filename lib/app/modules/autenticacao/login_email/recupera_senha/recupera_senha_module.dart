  import 'package:bloc_pattern/bloc_pattern.dart';
  import 'package:flutter/material.dart';
import 'package:squadrum/app/modules/autenticacao/login_email/recupera_senha/recupera_senha_page.dart';
  
  class RecuperaSenhaModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => RecuperaSenhaPage();

  static Inject get to => Inject<RecuperaSenhaModule>.of();

}
  