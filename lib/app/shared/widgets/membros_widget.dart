import 'package:flutter/material.dart';
import 'package:squadrum/app/modules/home/resumo/resumo_module.dart';
import 'package:squadrum/app/modules/home/resumo/squad/squad_bloc.dart';
import 'package:squadrum/app/modules/home/resumo/squad/usuario/usuario_page.dart';
import 'package:squadrum/app/shared/models/squad_model.dart';
import 'package:squadrum/app/shared/models/usuario_model.dart';

class MembrosWidget extends StatelessWidget {
  SquadBloc squadBloc = ResumoModule.to.getBloc<SquadBloc>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<SquadModel>(
        stream: squadBloc.squadOut,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            SquadModel squad = snapshot.data;
            return Container(
              padding: EdgeInsets.only(left: 0, top: 10),
              height: 185,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: squad.listaUsuarios.length,
                itemBuilder: (context, index) {
                  UsuarioModel usuario = squad.listaUsuarios[index];
                  double margemEsquerda = index == 0 ? 20 : 7;
                  double margemDireita =
                      index == squad.listaUsuarios.length - 1 ? 20 : 7;
                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => UsuarioPage(usuario: usuario,)));
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: margemEsquerda,
                            right: margemDireita,
                            bottom: 15,
                            top: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            //color: Color(0xffECEFF1),
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 3.0,
                                  offset: Offset(0.0, 4.0))
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    top: 15, left: 15, right: 15),
                                child: CircleAvatar(
                                  minRadius: 18,
                                  maxRadius: 36,
                                  backgroundImage: NetworkImage(
                                    usuario.urlImagem,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  usuario.nome.split(" ")[0].trim(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  usuario.cargo.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                ),
                              )
                            ],
                          ),
                        ),
                      ));
                },
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
            );
          }
        },
      ),
    );
  }
}
