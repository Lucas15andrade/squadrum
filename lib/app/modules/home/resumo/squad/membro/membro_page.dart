import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:squadrum/app/modules/home/resumo/squad/membro/membro_bloc.dart';
import 'package:squadrum/app/modules/home/resumo/squad/squad_module.dart';
import 'package:squadrum/app/services/firebase_service.dart';
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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: TituloWidget("Pesquise um usuário"),
              ),
              Container(
                margin: EdgeInsets.all(20),
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
              Container(
                //height: 200,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
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
                ),
                child: StreamBuilder<UsuarioModel>(
                  stream: membroBloc.usuarioOut,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data.id == null) {
                      return Center(
                        child: Text("Usuário não encontrado"),
                      );
                    } else {
                      UsuarioModel usuario = snapshot.data;
                      return Container(
                          child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: CircleAvatar(
                                  minRadius: 18,
                                  maxRadius: 36,
                                  backgroundImage: NetworkImage(
                                    usuario.urlImagem,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    usuario.nome,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 23),
                                    maxLines: 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RaisedButton(
                                color: Colors.grey[200],
                                child: Text("Cancelar", style: TextStyle(color: Colors.black),),
                                onPressed: () {},
                              ),
                              RaisedButton(
                                color: Theme.of(context).primaryColor,
                                child: Text("Adicionar", style: TextStyle(color: Colors.white),),
                                onPressed: () async {
                                  bool jaAdicionado = await FirebaseService.verificaUsuarioJaAdicionado(usuario);
                                  print("Usuário adicionado: ");
                                  print(jaAdicionado);
                                },
                              ),
                            ],
                          )
                        ],
                      ));
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
