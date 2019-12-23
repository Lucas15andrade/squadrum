import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:squadrum/app/app_bloc.dart';

class DrawerPersonalizado extends StatelessWidget {
  final PageController _pageController;
  //final AppBloc appBloc;
  final FirebaseUser firebaseUser;

  DrawerPersonalizado(
    this._pageController,
    this.firebaseUser,
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
      child: Stack(
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
                                "Olá, ${firebaseUser.email}",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                child: Text(
                                  "Entre ou cadastre-se",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  /* if (!model.isLoggedIn()) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                  } else {
                                    model.signOut();
                                  } */
                                },
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ])
        ],
      ),
    );
  }
}
