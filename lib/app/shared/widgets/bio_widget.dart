import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:squadrum/app/shared/models/usuario_model.dart';

class BioWidget extends StatelessWidget {
  UsuarioModel usuario;

  BioWidget({@required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 10),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 4.0))
            ],
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Center(
                  child: Text(
                    usuario.cargo,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(usuario.bio,
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.roboto(
                        fontSize: 15, fontWeight: FontWeight.w400)),
              ),
            ],
          )),
    );
  }
}
