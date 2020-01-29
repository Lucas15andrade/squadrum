import 'package:flutter/material.dart';
import 'package:squadrum/app/modules/home/resumo/resumo_module.dart';
import 'package:squadrum/app/modules/home/resumo/squad/squad_bloc.dart';
import 'package:squadrum/app/modules/home/resumo/squad/squad_module.dart';
import 'package:squadrum/app/shared/models/squad_model.dart';

class SquadWidget extends StatelessWidget {
  SquadModel squad;

  SquadWidget(this.squad);

  @override
  Widget build(BuildContext context) {
    Color corPrimaria = Theme.of(context).primaryColor;

    return GestureDetector(
        onTap: () {
          //ResumoModule.to.getBloc<SquadBloc>().squadIn.add(squad);
          print(squad.listaUsuarios.toString());
          ResumoModule.to.getBloc<SquadBloc>().adicionaSquad(squad);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => SquadModule()));
        },
        child: Container(
          //padding: EdgeInsets.all(20),
          padding: EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 10),
          width: 330,
          height: 100,
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 10.0))
                ],
                gradient: LinearGradient(
                    colors: [Colors.blue[200], corPrimaria],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  minRadius: 22,
                  maxRadius: 44,
                  backgroundImage: NetworkImage(
                    squad.urlImagem,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 180,
                  child: Text(
                    squad.titulo,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                    maxLines: 2,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
