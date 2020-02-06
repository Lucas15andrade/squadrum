import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:squadrum/app/app_bloc.dart';
import 'package:squadrum/app/app_module.dart';
import 'package:squadrum/app/services/firebase_service.dart';
import 'package:squadrum/app/shared/models/squad_model.dart';
import 'package:squadrum/app/shared/widgets/input_widget.dart';

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
                  (s) {},
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
                  (s) {},
                  cor: Colors.black,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 43,
                  child: RaisedButton(
                    onPressed: () async {
                      print("Salvar");
                      String uid =
                          AppModule.to.bloc<AppBloc>().firebaseUser.uid;

                      print(uid);

                      SquadModel squad = SquadModel(
                          titulo: _tituloController.text,
                          descricao: _descricaoController.text,
                          membros: [uid]);

                      await FirebaseService.salvarSquad(squad, file);
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
