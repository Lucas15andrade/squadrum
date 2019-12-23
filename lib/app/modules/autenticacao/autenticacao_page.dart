import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:squadrum/app/modules/autenticacao/login_email/login_email_module.dart';
import 'package:squadrum/app/shared/widgets/login_widget.dart';

class AutenticacaoPage extends StatefulWidget {
  @override
  _AutenticacaoPageState createState() => _AutenticacaoPageState();
}

class _AutenticacaoPageState extends State<AutenticacaoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[800],
        //appBar: AppBar(),
        body: Container(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 150),
                child: Align(
                  child: Text("SQUADRUM",
                      style: GoogleFonts.josefinSans(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          textStyle: TextStyle(color: Colors.white))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Align(
                  child: Text("Gerenciamento de tarefas de squads",
                      style: GoogleFonts.cabin(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          textStyle: TextStyle(color: Colors.white))),
                ),
              ),
              SizedBox(
                height: 200,
              ),
              LoginWidget(
                corTexo: Colors.white,
                texto: "Logar com o Google",
                icone: Icon(
                  FontAwesomeIcons.google,
                  color: Colors.red,
                  size: 35,
                ),
                callback: null,
              ),
              SizedBox(
                height: 15,
              ),
              LoginWidget(
                corTexo: Colors.white,
                texto: "Logar com o E-mail",
                icone: Icon(
                  Icons.email,
                  color: Colors.white,
                  size: 35,
                ),
                callback: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LoginEmailModule()));
                },
              ),
            ],
          ),
        ));
  }
}
