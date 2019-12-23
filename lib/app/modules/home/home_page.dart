import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:squadrum/app/app_bloc.dart';
import 'package:squadrum/app/app_module.dart';
import 'package:squadrum/app/modules/autenticacao/autenticacao_module.dart';
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
    return StreamBuilder<FirebaseUser>(
      stream: appBloc.userOut,
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return AutenticacaoModule();
        }

        return PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Scaffold(
              appBar: AppBar(
                title: Text("Resumo"),
                centerTitle: true,
              ),
              drawer: DrawerPersonalizado(_pageController, snapshot.data),
            )
          ],
        );
      },
    );
  }
}
