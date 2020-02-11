import 'package:flutter/material.dart';

class Utils {
  static Widget sucesso(context, mensagem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Image.asset(
            "assets/images/okay.png",
            width: 300,
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          mensagem,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ],
    );
  }

  static Widget carregando(context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          /* SizedBox(
            height: 30,
          ), */
          Center(
            child: Image.asset(
              "assets/images/cloud.png",
              width: 250,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          CircularProgressIndicator(
            backgroundColor: Theme.of(context).primaryColor,
          ),
          SizedBox(
            height: 25,
          ),
          Text("Estamos salvando...",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
        ],
      ),
    );
  }
}
