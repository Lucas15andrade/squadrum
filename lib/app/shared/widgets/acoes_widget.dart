import 'package:flutter/material.dart';
import 'package:squadrum/app/modules/home/resumo/squad/membro/membro_module.dart';

class AcoesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  child: buildAcao(
                      acao: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MembroModule()));
                      },
                      texto: "Adicionar Membro",
                      imagem: AssetImage("assets/icons/add.png"))),
              Expanded(
                  child: buildAcao(
                      acao: () {},
                      texto: "Adicionar Evento",
                      imagem: AssetImage("assets/icons/calendar.png"))),
              Expanded(
                  child: buildAcao(
                      acao: () {},
                      texto: "Ordem de Serviço",
                      imagem: AssetImage("assets/icons/os.png"))),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: buildAcao(
                      acao: () {},
                      texto: "Metas",
                      imagem: AssetImage("assets/icons/goal.png"))),
              Expanded(
                  child: buildAcao(
                      acao: () {},
                      texto: "Medidas de Direção",
                      imagem: AssetImage("assets/icons/direction.png"))),
              Expanded(
                  child: Container()),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildAcao({@required acao, @required texto, @required imagem}) {
    return GestureDetector(
        onTap: acao,
        child: Container(
          height: 145,
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 10),
          child: Container(
            decoration: BoxDecoration(
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
                  width: 35,
                  height: 35,
                  margin: EdgeInsets.only(
                    top: 20,
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(fit: BoxFit.fill, image: imagem)),
                ),
                Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Center(
                      child: Text(
                        texto,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        maxLines: 2,
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}
