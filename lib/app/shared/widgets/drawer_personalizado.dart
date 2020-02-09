import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:squadrum/app/app_bloc.dart';
import 'package:squadrum/app/app_module.dart';
import 'package:squadrum/app/shared/models/usuario_model.dart';

class DrawerPersonalizado extends StatelessWidget {
  final PageController _pageController;
  final appBloc = AppModule.to.getBloc<AppBloc>();
  FirebaseUser firebaseUser;
  UsuarioModel usuario;

  DrawerPersonalizado(
    this._pageController,
    this.usuario,
  );
  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 203, 236, 241),
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
        );

    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(usuario.urlImagem),
            ),
            accountName: Text("Olá, ${usuario.nome} ${usuario.sobrenome}"),
            accountEmail: Text("${usuario.firebaseUser.email}")),
        ListTile(
          enabled: false,
          title: Text("Perfil"),
          leading: Icon(FontAwesomeIcons.user),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          enabled: false,
          title: Text("Sobre"),
          leading: Icon(Icons.info),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        ListTile(
          title: Text("Sair"),
          leading: Icon(Icons.exit_to_app),
          onTap: () async {
            Navigator.of(context).pop();
            await appBloc.signOut();
          },
        ),
      ],
    ));
  }
}

/* Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
              padding: EdgeInsets.only(left: 32.0, top: 16.0),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 8.0),
                  padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                  height: 170.0,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 8.0,
                        left: 8.0,
                        child: Text(
                          "Squadrum",
                          style: TextStyle(
                              fontSize: 34.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Positioned(
                          left: 0.0,
                          bottom: 0.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Olá, ${usuario.nome}",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                child: Text(
                                  "Sair",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () async{
                                  Navigator.of(context).pop();
                                  await appBloc.signOut();
                                },
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ])
        ],
      ), */
