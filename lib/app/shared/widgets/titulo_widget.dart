import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TituloWidget extends StatelessWidget {
  final String titulo;

  TituloWidget(this.titulo);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, top: 15),
      child: Text(
        titulo,
        style: GoogleFonts.roboto(
            fontSize: 23,
            fontWeight: FontWeight.w600,
            textStyle: TextStyle(color: Color(0xff37474F))),
      ),
    );
  }
}
