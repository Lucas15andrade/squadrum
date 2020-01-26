import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:squadrum/app/app_bloc.dart';
import 'package:squadrum/app/app_module.dart';
import 'package:squadrum/app/modules/autenticacao/autenticacao_module.dart';
import 'package:squadrum/app/modules/home/resumo/resumo_module.dart';
import 'package:squadrum/app/shared/models/usuario_model.dart';
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
    return StreamBuilder<ConnectivityResult>(
      stream: appBloc.conOut,
      builder: (context, snapshot) {
        if (snapshot.data == ConnectivityResult.none) {
          return Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/not.png",
                    width: 300,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Não conseguimos nos conectar ao servidor. Por favor verifique sua conexão a internet!",
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
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
                      drawer:
                          DrawerPersonalizado(_pageController, snapshot.data),
                      body: ResumoModule(),
                    )
                  ],
                );
              } else if (!snapshot.hasData ||
                  snapshot.data.firebaseUser == null) {
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
      },
    );
  }
}
