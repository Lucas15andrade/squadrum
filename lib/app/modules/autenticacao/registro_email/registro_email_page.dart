import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:squadrum/app/modules/autenticacao/autenticacao_bloc.dart';
import 'package:squadrum/app/modules/autenticacao/autenticacao_module.dart';
import 'package:squadrum/app/modules/autenticacao/registro_email/registro_email_bloc.dart';
import 'package:squadrum/app/shared/models/cargo.dart';
import 'package:squadrum/app/shared/widgets/input_widget.dart';

class RegistroEmailPage extends StatefulWidget {
  final String title;
  const RegistroEmailPage({Key key, this.title = "RegistroEmail"})
      : super(key: key);

  @override
  _RegistroEmailPageState createState() => _RegistroEmailPageState();
}

class _RegistroEmailPageState extends State<RegistroEmailPage> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _nomeController = TextEditingController();
  final _sobrenomeController = TextEditingController();
  final _nickController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final autenticacaoBloc = AutenticacaoModule.to.getBloc<AutenticacaoBloc>();
  final registroBloc = AutenticacaoModule.to.bloc<RegistroEmailBloc>();

  bool nicknameExiste = false;
  List<DropdownMenuItem<Cargo>> _dropdownCargos;
  List<Cargo> cargos = [
    Cargo(titulo: "Desenvolvedor", valor: "DEV"),
    Cargo(titulo: "Requisitos", valor: "REQ")
  ];
  Cargo cargoAtual;

  @override
  void initState() {
    _dropdownCargos = buildDropdownCargos();
    cargoAtual = cargos[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.blue[800],
        appBar: AppBar(
          centerTitle: true,
          title: Text("Cadastro"),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Cadastre seu usuário",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                  maxLines: 2,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InputWidget(_nomeController, "Nome", (text) {
                if (text.isEmpty || text.length < 2) return "Nome muito curto!";
              },
                  1,
                  Icon(
                    FontAwesomeIcons.userCircle,
                    color: Colors.white,
                  ),
                  (s) {}),
              SizedBox(
                height: 20,
              ),
              InputWidget(_sobrenomeController, "Sobrenome", (text) {
                if (text.isEmpty || text.length < 2)
                  return "Sobrenome muito curto!";
              },
                  1,
                  Icon(
                    FontAwesomeIcons.userCircle,
                    color: Colors.white,
                  ),
                  (s) {}),
              SizedBox(
                height: 20,
              ),
              InputWidget(
                  _nickController,
                  "Nickname",
                  (text) {
                    if (text.isEmpty || text.length < 6)
                      return "Nickname muito curto!";
                    else if (text.contains(" "))
                      return "Não pode conter espaços vazios";
                  },
                  1,
                  Icon(
                    FontAwesomeIcons.userTag,
                    color: Colors.white,
                  ),
                  (s) {
                    if (s != null && s.length > 0) {
                      registroBloc.pesquisaNickname(s.trim().toLowerCase());
                    }
                  }),
              StreamBuilder(
                stream: registroBloc.registroEmailOut,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data && _nickController.text.length > 0) {
                      nicknameExiste = true;
                      return Container(
                        margin: EdgeInsets.only(left: 12),
                        child: Text(
                          "Nickname já existe!",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      );
                    } else if (!snapshot.data &&
                        _nickController.text.length > 0 &&
                        !_nickController.text.contains(" ")) {
                      nicknameExiste = false;
                      return Container(
                        margin: EdgeInsets.only(left: 12),
                        child: Text(
                          "Nickname disponível!",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    return Container();
                  } else {
                    return Container();
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              InputWidget(
                _emailController,
                "E-mail",
                (text) {
                  if (text.isEmpty || !text.contains("@"))
                    return "E-mail inválido!";
                },
                1,
                Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                (s) {},
                inputType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 20,
              ),
              InputWidget(
                _senhaController,
                "Senha",
                (text) {
                  if (text.isEmpty || text.length < 6) return "Senha inválida!";
                },
                2,
                Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                (s) {},
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Cargo:",
                    style: TextStyle(
                        color: Theme.of(context).accentColor, fontSize: 20),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Theme(
                    data: Theme.of(context)
                        .copyWith(canvasColor: Colors.blue[800]),
                    child: DropdownButton(
                      value: cargoAtual,
                      items: _dropdownCargos,
                      icon: Icon(
                        Icons.arrow_downward,
                        color: Colors.white,
                      ),
                      onChanged: onChangeDropdownCargoItem,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 20,
                child: SizedBox(
                  height: 50,
                  width: 10,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate() && !nicknameExiste) {
                        Map<String, dynamic> dadosUsuario = {
                          "nome": _nomeController.text,
                          "sobrenome": _sobrenomeController.text,
                          "nickname": _nickController.text.trim().toLowerCase(),
                          "email": _emailController.text,
                          "cargo": cargoAtual.valor,
                          "bio": "",
                          "squads": []
                        };
                        autenticacaoBloc.signUp(
                            userData: dadosUsuario,
                            pass: _senhaController.text,
                            onSuccess: _onSuccess,
                            onFail: _onFail);
                      }
                    },
                    child: Text(
                      "Cadastrar",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget cargo() {
    return DropdownButton(
        value: cargoAtual,
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (Cargo novoCargo) {
          setState(() {
            cargoAtual = novoCargo;
          });
        },
        items: _dropdownCargos);
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao criar usuário!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }

  List<DropdownMenuItem<Cargo>> buildDropdownCargos() {
    return cargos.map((c) {
      return DropdownMenuItem(
        child: Text(c.titulo),
        value: c,
      );
    }).toList();
  }

  onChangeDropdownCargoItem(Cargo month) {
    setState(() {
      cargoAtual = month;
    });
  }
}
