import 'package:flutter/material.dart';
import 'package:squadrum/app/modules/home/home_module.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Squadrum',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[800],
        accentColor: Colors.white,
        errorColor: Colors.white,
        backgroundColor: Colors.white
      ),
      home: HomeModule(),
    );
  }
}
