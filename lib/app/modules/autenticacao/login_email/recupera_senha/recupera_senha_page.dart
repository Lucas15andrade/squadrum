import 'package:flutter/material.dart';

class RecuperaSenhaPage extends StatefulWidget {
  
  final String title;
  const RecuperaSenhaPage({Key key, this.title = "RecuperaSenha"}) : super(key: key);

  @override
  _RecuperaSenhaPageState createState() => _RecuperaSenhaPageState();
}

class _RecuperaSenhaPageState extends State<RecuperaSenhaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
  