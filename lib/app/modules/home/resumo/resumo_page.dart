import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:squadrum/app/app_bloc.dart';
import 'package:squadrum/app/app_module.dart';
import 'package:squadrum/app/shared/models/squad_model.dart';
import 'package:squadrum/app/shared/teste_page.dart';
import 'package:squadrum/app/shared/widgets/caixa_widget.dart';
import 'package:squadrum/app/shared/widgets/squad_widget.dart';
import 'package:squadrum/app/shared/widgets/titulo_widget.dart';

class ResumoPage extends StatefulWidget {
  final String title;

  const ResumoPage({Key key, this.title = "Resumo"}) : super(key: key);

  @override
  _ResumoPageState createState() => _ResumoPageState();
}

class _ResumoPageState extends State<ResumoPage> {
  AppBloc appBloc = AppModule.to.getBloc<AppBloc>();

  @override
  Widget build(BuildContext context) {

/*     appBloc.conOut.listen((data) {
      if(data == ConnectivityResult.none){
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => TestePage()));
      }
    }); */

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.add,
            color: Theme.of(context).accentColor,
          ),
          onPressed: () {
            /* Navigator.push(context,
                MaterialPageRoute(builder: (context) {}); */
          },
        ),
        body: SingleChildScrollView(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: TituloWidget("Squads"),
            ),
            Container(
              height: 170,
              child: StreamBuilder<List<SquadModel>>(
                stream: appBloc.squadOut,
                builder: (context, snapshot) {
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
                      margin: EdgeInsets.only(top: 20),
                      child: Text("Você não possui squads!"),
                    );
                  }
                },
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TituloWidget("Lembretes"),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: CaixaWidget(),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: CaixaWidget(),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: CaixaWidget(),
            )
          ],
        )));
  }
}
