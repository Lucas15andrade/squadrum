import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:squadrum/app/app_bloc.dart';
import 'package:squadrum/app/app_module.dart';
import 'package:squadrum/app/modules/home/resumo/novo_squad/novo_squad_bloc.dart';
import 'package:squadrum/app/modules/home/resumo/novo_squad/novo_squad_module.dart';
import 'package:squadrum/app/modules/home/resumo/resumo_page.dart';
import 'package:squadrum/app/shared/enums/status.dart';
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

  NovoSquadBloc novoSquadBloc = NovoSquadModule.to.getBloc<NovoSquadBloc>();

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/images/okay.png"), context);
    precacheImage(AssetImage("assets/images/cloud.png"), context);

    novoSquadBloc.sucessoOut.listen((data) async {
      if (data == Status.SUCESSO) {
        if (Navigator.of(context).canPop()) {
          await Future.delayed(Duration(seconds: 3));
          Navigator.of(context).pop();
        }
      }
    });

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: StreamBuilder<Status>(
          stream: novoSquadBloc.sucessoOut,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == Status.VAZIO) {
                return Form(
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
                                          ? AssetImage(
                                              "assets/images/camera.png")
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
                            if (text.isEmpty)
                              return "O título não pode ser vazio!";
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
                            if (text.isEmpty)
                              return "A descrição não pode ser vazia!";
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
                              if (_formKey.currentState.validate()) {
                                String uid = AppModule.to
                                    .bloc<AppBloc>()
                                    .firebaseUser
                                    .uid;

                                SquadModel squad = SquadModel(
                                    titulo: _tituloController.text,
                                    descricao: _descricaoController.text,
                                    membros: [uid]);

                                await novoSquadBloc.adicionarSquad(squad, file);
                              }
                            },
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              "Salvar",
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 18),
                            ),
                          ),
                        )
                      ],
                    ));
              } else if (snapshot.data == Status.CARREGANDO) {
                return carregando(context);
              } else if (snapshot.data == Status.SUCESSO) {
                return sucesso(context);
              } else {
                return Container();
              }
            } else {
              return Container();
            }
          },
        ));
  }

  Widget sucesso(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Image.asset(
            "assets/images/okay.png",
            width: 300,
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Text(
          "Cadastro feito com sucesso!",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ],
    );
  }

  Widget carregando(context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          /* SizedBox(
            height: 30,
          ), */
          Center(
            child: Image.asset(
              "assets/images/cloud.png",
              width: 250,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          CircularProgressIndicator(
            backgroundColor: Theme.of(context).primaryColor,
          ),
          SizedBox(
            height: 25,
          ),
          Text("Estamos salvando...",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))
        ],
      ),
    );
  }
}
