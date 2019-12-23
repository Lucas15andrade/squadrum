import 'package:flutter/material.dart';

class CustomDrawerPage extends StatefulWidget {
  
  final String title;
  const CustomDrawerPage({Key key, this.title = "CustomDrawer"}) : super(key: key);

  @override
  _CustomDrawerPageState createState() => _CustomDrawerPageState();
}

class _CustomDrawerPageState extends State<CustomDrawerPage> {
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
  