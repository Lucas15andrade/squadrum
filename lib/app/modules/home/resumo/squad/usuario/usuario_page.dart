import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:squadrum/app/services/firebase_service.dart';
import 'package:squadrum/app/shared/models/usuario_model.dart';
import 'package:squadrum/app/shared/widgets/bio_widget.dart';
import 'package:squadrum/app/shared/widgets/cabecalho_usuario.dart';
import 'package:squadrum/app/shared/widgets/titulo_widget.dart';

class UsuarioPage extends StatefulWidget {
  final String title;
  final UsuarioModel usuario;
  const UsuarioPage({Key key, this.title = "Usuario", this.usuario})
      : super(key: key);

  @override
  _UsuarioPageState createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Usuário"),
        ),
        body: ListView(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: TituloWidget("Informações"),
            ),
            CabecalhoUsuario(
              usuario: widget.usuario,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TituloWidget("Biografia"),
            ),
            BioWidget(usuario: widget.usuario),
            Container(
              margin: EdgeInsets.all(20),
              child: RaisedButton(
                onPressed: () async {
                  await FirebaseService.removeMembro(widget.usuario);
                  Navigator.of(context).pop();
                },
                color: Colors.red[500],
                child: Text(
                  "Remover",
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
              ),
            )
          ],
        ));
  }
}
