import 'package:flutter/material.dart';

class VazioWidget extends StatelessWidget {
  String texto;

  VazioWidget({@required this.texto});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 10),
      //height: 150,
      //width: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.asset(
              "assets/images/not-found.png",
              width: 150,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            texto,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
