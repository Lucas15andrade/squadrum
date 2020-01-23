import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:squadrum/app/modules/home/resumo/squad/membro/membro_bloc.dart';
import 'package:squadrum/app/modules/home/resumo/squad/squad_module.dart';
import 'package:squadrum/app/shared/models/usuario_model.dart';
import 'package:squadrum/app/shared/widgets/input_widget.dart';
import 'package:squadrum/app/shared/widgets/titulo_widget.dart';

class MembroPage extends StatefulWidget {
  @override
  _MembroPageState createState() => _MembroPageState();
}

class _MembroPageState extends State<MembroPage> {
  final _usuarioController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    MembroBloc membroBloc = SquadModule.to.getBloc<MembroBloc>();

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Membro"),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: TituloWidget("Pesquise um usuário"),
              ),
              Container(
                margin: EdgeInsets.all(20),
                /* padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: Offset(0.0, 1.0))
                  ],
                ), */
                child: Form(
                  key: _formKey,
                  child: InputWidget(
                    _usuarioController,
                    "Nickname",
                    (text) {
                      if (text.isEmpty || !text.contains("@"))
                        return "E-mail inválido!";
                    },
                    1,
                    Icon(
                      FontAwesomeIcons.user,
                      color: Colors.black,
                    ),
                    (s) {
                      membroBloc.pesquisaNickname(s);
                    },
                    cor: Colors.black,
                  ),
                ),
              ),
              StreamBuilder<UsuarioModel>(
                stream: membroBloc.usuarioOut,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text("Usuário não encontrado"),
                    );
                  } else {
                    return Container(
                      padding: EdgeInsets.all(20),
                      height: 200,
                      //width: 200,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10.0,
                                offset: Offset(0.0, 10.0))
                          ],
                        ),
                        child: Text("ok"),
                      ),
                    );
                  }
                },
              )
            ],
          ),
        ));
  }
}
