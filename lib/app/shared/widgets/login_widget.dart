import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget {
  final String texto;
  final Color corTexo;
  final Icon icone;
  final VoidCallback callback;

  LoginWidget(
      {@required this.icone,
      @required this.texto,
      @required this.corTexo,
      @required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 0),
        width: 250,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: new BorderRadius.all(new Radius.circular(4.0)),
          gradient: LinearGradient(
            begin: AlignmentDirectional.bottomStart,
            end: AlignmentDirectional.topEnd,
            tileMode: TileMode.repeated,
            colors: [
              Colors.blue[900],
              Colors.blue[700],
            ],
          ),
        ),
        child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              icone,
              Text(
                texto,
                style: TextStyle(
                    color: corTexo, fontSize: 20, fontWeight: FontWeight.w300),
              )
            ],
          ),
          onTap: callback,
        ));
  }
}
