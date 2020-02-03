import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:squadrum/app/shared/widgets/input_widget.dart';
import 'package:squadrum/app/shared/widgets/titulo_widget.dart';

class NovoSquadPage extends StatefulWidget {
  final String title;
  const NovoSquadPage({Key key, this.title = "Novo Squad"}) : super(key: key);

  @override
  _NovoSquadPageState createState() => _NovoSquadPageState();
}

class _NovoSquadPageState extends State<NovoSquadPage> {
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  File file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Logo",
                    style: GoogleFonts.roboto(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                        textStyle: TextStyle(color: Color(0xff37474F))),
                    maxLines: 2,
                  ),
                ),
                Container(
                    child: Center(
                  child: GestureDetector(
                    onTap: () async {
                      File image = await ImagePicker.pickImage(
                          source: ImageSource.gallery);
                      setState(() {
                        file = image;
                      });
                    },
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: file == null
                                  ? AssetImage("assets/images/camera.png")
                                  : FileImage(file))),
                    ),
                  ),
                )),
                SizedBox(
                  height: 15,
                ),
                InputWidget(
                  _tituloController,
                  "Título",
                  (text) {
                    if (text.isEmpty) return "O título não pode ser vazio!";
                  },
                  1,
                  Icon(
                    Icons.text_fields,
                    color: Colors.black,
                  ),
                  (s) {
                    //membroBloc.pesquisaNickname(s);
                  },
                  cor: Colors.black,
                ),
                SizedBox(
                  height: 15,
                ),
                InputWidget(
                  _descricaoController,
                  "Descrição",
                  (text) {
                    if (text.isEmpty) return "A descrição não pode ser vazia!";
                  },
                  1,
                  Icon(
                    Icons.text_fields,
                    color: Colors.black,
                  ),
                  (s) {
                    //membroBloc.pesquisaNickname(s);
                  },
                  cor: Colors.black,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 40,
                  child: RaisedButton(
                    onPressed: () {
                      print("Salvar");
                    },
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      "Salvar",
                      style: TextStyle(
                          color: Theme.of(context).accentColor, fontSize: 18),
                    ),
                  ),
                )
              ],
            )));
  }
}
