import 'package:flutter/material.dart';
import 'package:squadrum/app/modules/autenticacao/autenticacao_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Squadrum',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xff0277BD),
          accentColor: Colors.white,
          //backgroundColor: Color(0xff0277BD)
          ),
      home: AutenticacaoPage(),
    );
  }
}
