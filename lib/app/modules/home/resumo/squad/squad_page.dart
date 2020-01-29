import 'package:flutter/material.dart';
import 'package:squadrum/app/shared/widgets/acoes_widget.dart';
import 'package:squadrum/app/shared/widgets/cabecalho_squad.dart';
import 'package:squadrum/app/shared/widgets/membros_widget.dart';
import 'package:squadrum/app/shared/widgets/titulo_widget.dart';

class SquadPage extends StatefulWidget {
  @override
  _SquadPageState createState() => _SquadPageState();
}

class _SquadPageState extends State<SquadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Detalhes"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: TituloWidget("Detalhes"),
              ),
              CabecalhoSquad(),
              Align(
                alignment: Alignment.centerLeft,
                child: TituloWidget("Membros"),
              ),
              MembrosWidget(),
              /* Align(
                alignment: Alignment.centerLeft,
                child: TituloWidget("Lembretes"),
              ),
              MembrosWidget(), */
              Align(
                alignment: Alignment.centerLeft,
                child: TituloWidget("Ações"),
              ),
              AcoesWidget()
            ],
          ),
        ));
  }
}

/* floatingActionButton: SpeedDial(
          overlayColor: Colors.grey,
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
                child: Icon(
                  FontAwesomeIcons.user,
                  color: Colors.white,
                ),
                backgroundColor: Theme.of(context).primaryColor,
                label: "Adicionar Membro",
                onTap: () {}),
            SpeedDialChild(
                child: Icon(
                  Icons.event,
                  color: Colors.white,
                ),
                backgroundColor: Theme.of(context).primaryColor,
                label: "Adicionar Lembrete",
                onTap: () {}),
            SpeedDialChild(
                child: Icon(
                  FontAwesomeIcons.edit,
                  color: Colors.white,
                ),
                backgroundColor: Theme.of(context).primaryColor,
                label: "Editar Squad",
                onTap: () {})
          ],
        ), */