import 'package:flutter/material.dart';
import 'package:squadrum/app/modules/home/resumo/squad/evento/evento_bloc.dart';
import 'package:squadrum/app/modules/home/resumo/squad/evento/evento_module.dart';

class EventoPage extends StatefulWidget {
  final String title;
  const EventoPage({Key key, this.title = "Evento"}) : super(key: key);

  @override
  _EventoPageState createState() => _EventoPageState();
}

class _EventoPageState extends State<EventoPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  EventoBloc membroBloc = EventoModule.to.getBloc<EventoBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            adicionaEvento();
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.add,
            color: Theme.of(context).accentColor,
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[],
          ),
        ));
  }

  void adicionaEvento() {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
            title: Text("Novo evento"),
            content: Container(
              height: 200,
              width: 100,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[Text("Título"), TextFormField()],
                  )
                ],
              ),
            )));
  }
}
