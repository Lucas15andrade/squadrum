import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TituloWidget extends StatelessWidget {
  final String titulo;

  TituloWidget(this.titulo);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, top: 15),
      child: Text(
        titulo,
        style: GoogleFonts.roboto(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            textStyle: TextStyle(color: Colors.black)),
      ),
    );
  }
}
