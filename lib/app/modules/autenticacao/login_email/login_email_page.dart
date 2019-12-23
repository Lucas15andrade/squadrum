import 'package:flutter/material.dart';
import 'package:squadrum/app/app_bloc.dart';
import 'package:squadrum/app/app_module.dart';
import 'package:squadrum/app/modules/home/home_module.dart';
import 'package:squadrum/app/shared/widgets/input_widget.dart';

class LoginEmailPage extends StatefulWidget {
  final String title;
  const LoginEmailPage({Key key, this.title = "LoginEmail"}) : super(key: key);

  @override
  _LoginEmailPageState createState() => _LoginEmailPageState();
}

class _LoginEmailPageState extends State<LoginEmailPage> {
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final bloc = AppModule.to.getBloc<AppBloc>();

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
                height: 40,
              ),
              InputWidget(_emailController, "E-mail", (text) {
                if (text.isEmpty || !text.contains("@"))
                  return "E-mail inválido!";
              }, 1),
              SizedBox(
                height: 20,
              ),
              InputWidget(_senhaController, "Senha", (text) {
                if (text.isEmpty || text.length < 6) return "Senha inválida!";
              }, 2),
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
                      if (_formKey.currentState.validate()) {}
                      bloc.signIn(
                          email: _emailController.text,
                          pass: _senhaController.text,
                          onSuccess: _onSuccess,
                          onFail: _onFail);
                    },
                    child: Text(
                      "Entrar",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void _onSuccess() {
   /*  Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomeModule())); */
         Navigator.of(context).pop();
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao Entrar!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
