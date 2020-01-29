import 'package:flutter/material.dart';

class TestePage extends StatefulWidget {
  @override
  _TestePageState createState() => _TestePageState();
}

class _TestePageState extends State<TestePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/not.png",
              width: 300,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Não conseguimos nos conectar ao servidor. Por favor verifique sua conexão a internet!",
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
