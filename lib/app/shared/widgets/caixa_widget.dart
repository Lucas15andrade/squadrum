import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:squadrum/app/shared/models/squad_model.dart';

class CaixaWidget extends StatelessWidget {
  SquadModel squad;

  CaixaWidget({@required this.squad});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 12),
      height: 70,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: Offset(0.0, 2.0))
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 15),
              child: CircleAvatar(
                minRadius: 10,
                maxRadius: 20,
                backgroundImage: NetworkImage(
                  "https://previews.123rf.com/images/inkdrop/inkdrop1910/inkdrop191006642/132480573-letter-d-distorted-neon-glitch-effect-text-font-3d-render.jpg",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              width: 190,
              child: Text("Reunião diária",
                  maxLines: 2,
                  style: GoogleFonts.roboto(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      textStyle: TextStyle(color: Colors.black))),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              //width: 150,
              child: Text("14H",
                  maxLines: 2,
                  style: GoogleFonts.roboto(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      textStyle: TextStyle(color: Colors.black))),
            ),
          ],
        ),
      ),
    );
  }
}
