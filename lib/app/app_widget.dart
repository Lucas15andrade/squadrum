import 'package:flutter/material.dart';
import 'package:squadrum/app/modules/home/home_module.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Squadrum',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff0277BD),
        accentColor: Colors.white,
        errorColor: Colors.white
      ),
      home: HomeModule(),
    );
  }
}
