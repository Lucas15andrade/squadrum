import 'package:flutter/material.dart';
import 'package:squadrum/app/app_bloc.dart';
import 'package:squadrum/app/app_module.dart';
import 'package:squadrum/app/modules/autenticacao/autenticacao_bloc.dart';
import 'package:squadrum/app/modules/autenticacao/autenticacao_module.dart';
import 'package:squadrum/app/shared/widgets/input_widget.dart';

class RecuperaSenhaPage extends StatefulWidget {
  final String title;
  const RecuperaSenhaPage({Key key, this.title = "RecuperaSenha"})
      : super(key: key);

  @override
  _RecuperaSenhaPageState createState() => _RecuperaSenhaPageState();
}

class _RecuperaSenhaPageState extends State<RecuperaSenhaPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final autenticacaoBloc = AutenticacaoModule.to.getBloc<AutenticacaoBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.blue[800],
        appBar: AppBar(
          title: Text("Login"),
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
                  "Digite seu e-mail",
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
              InputWidget(_emailController, "E-mail", (text) {
                if (text.isEmpty || !text.contains("@"))
                  return "E-mail inválido!";
              },
                  1,
                  Icon(
                    Icons.email,
                    color: Colors.white,
                  ),(s){}),
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
                      if (_formKey.currentState.validate()) {
                        autenticacaoBloc.recoverPass(_emailController.text);
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                          content: Text("Verifique seu e-mail!"),
                          backgroundColor: Colors.black,
                          duration: Duration(seconds: 3),
                        ));
                        Future.delayed(Duration(seconds: 4)).then((s) {
                          Navigator.of(context).pop();
                        });
                      }
                    },
                    child: Text(
                      "Recuperar",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
