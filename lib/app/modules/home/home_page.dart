import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:squadrum/app/app_bloc.dart';
import 'package:squadrum/app/app_module.dart';
import 'package:squadrum/app/modules/autenticacao/autenticacao_module.dart';
import 'package:squadrum/app/modules/home/home_module.dart';
import 'package:squadrum/app/modules/home/resumo/resumo_bloc.dart';
import 'package:squadrum/app/modules/home/resumo/resumo_module.dart';
import 'package:squadrum/app/shared/models/usuario_model.dart';
import 'package:squadrum/app/shared/teste_page.dart';
import 'package:squadrum/app/shared/widgets/drawer_personalizado.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController();

  final AppBloc appBloc = AppModule.to.getBloc<AppBloc>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UsuarioModel>(
      stream: appBloc.userOut,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.firebaseUser != null) {
          return PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              Scaffold(
                appBar: AppBar(
                  title: Text("Início"),
                  centerTitle: true,
                ),
                drawer: DrawerPersonalizado(_pageController, snapshot.data),
                body: ResumoModule(),
              )
            ],
          );
        } else if (!snapshot.hasData || snapshot.data.firebaseUser == null) {
          return AutenticacaoModule();
        } else {
          return Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text(
                    "Entrando...",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
