import 'package:flutter/material.dart';

class ResumoPage extends StatefulWidget {
  
  final String title;
  const ResumoPage({Key key, this.title = "Resumo"}) : super(key: key);

  @override
  _ResumoPageState createState() => _ResumoPageState();
}

class _ResumoPageState extends State<ResumoPage> {
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
  