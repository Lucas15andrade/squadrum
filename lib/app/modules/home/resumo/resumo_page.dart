import 'package:flutter/material.dart';
import 'package:squadrum/app/modules/home/resumo/resumo_bloc.dart';
import 'package:squadrum/app/modules/home/resumo/resumo_module.dart';
import 'package:squadrum/app/shared/models/squad_model.dart';
import 'package:squadrum/app/shared/widgets/squad_widget.dart';
import 'package:squadrum/app/shared/widgets/titulo_widget.dart';

class ResumoPage extends StatefulWidget {
  final String title;
  const ResumoPage({Key key, this.title = "Resumo"}) : super(key: key);

  @override
  _ResumoPageState createState() => _ResumoPageState();
}

class _ResumoPageState extends State<ResumoPage> {
  ResumoBloc resumoBloc = ResumoModule.to.getBloc<ResumoBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: TituloWidget("Squads"),
        ),
        Container(
          height: 180,
          child: StreamBuilder<List<SquadModel>>(
            stream: resumoBloc.squadOut,
            builder: (context, snapshot) {
              print(snapshot);
              if (snapshot.hasData) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return SquadWidget(snapshot.data[index]);
                  },
                );
              } else {
                return Container(
                  child: Text("SEM DADO"),
                );
              }
            },
          ),
        )
      ],
    )));
  }
}
