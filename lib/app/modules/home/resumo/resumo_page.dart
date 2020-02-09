import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:squadrum/app/app_bloc.dart';
import 'package:squadrum/app/app_module.dart';
import 'package:squadrum/app/modules/home/resumo/novo_squad/novo_squad_module.dart';
import 'package:squadrum/app/shared/models/squad_model.dart';
import 'package:squadrum/app/shared/widgets/caixa_widget.dart';
import 'package:squadrum/app/shared/widgets/squad_widget.dart';
import 'package:squadrum/app/shared/widgets/titulo_widget.dart';
import 'package:squadrum/app/shared/widgets/vazio_widget.dart';

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
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        floatingActionButton: SpeedDial(
          overlayColor: Colors.grey,
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: Theme.of(context).primaryColor,
                label: "Novo Squad",
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => NovoSquadModule()));
                }),
          ],
        ),
        body: RefreshIndicator(
            color: Theme.of(context).primaryColor,
            child: ListView(
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
                      if (snapshot.hasData && snapshot.data.length > 0) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return SquadWidget(snapshot.data[index]);
                          },
                        );
                      } else {
                        return VazioWidget(
                          texto: "Você ainda não possui Squad!",
                        );
                      }
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TituloWidget("Lembretes"),
                ),
                CaixaWidget(),
                CaixaWidget(),

                /*
                Flexible(
                  fit: FlexFit.loose,
                  child: CaixaWidget(),
                ),*/
              ],
            ),
            onRefresh: () async {
              await AppModule.to.getBloc<AppBloc>().carregaApenasSquads();
            }));
  }
}
