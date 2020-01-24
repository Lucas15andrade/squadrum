import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:squadrum/app/app_bloc.dart';
import 'package:squadrum/app/app_module.dart';
import 'package:squadrum/app/modules/home/resumo/resumo_module.dart';
import 'package:squadrum/app/modules/home/resumo/squad/squad_bloc.dart';
import 'package:squadrum/app/shared/models/squad_model.dart';
import 'package:squadrum/app/shared/widgets/titulo_widget.dart';

class CabecalhoSquad extends StatelessWidget {
  SquadBloc squadBloc = ResumoModule.to.getBloc<SquadBloc>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<SquadModel>(
        stream: squadBloc.squadOut,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
                padding: EdgeInsets.only(left: 20, top: 10, right: 20),
                height: 140,
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
                          colors: [
                            Colors.blue[200],
                            Theme.of(context).primaryColor
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp)),
                  //margin: EdgeInsets.only(left: 15, top: 15, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: GestureDetector(
                          onTap: () async {
                            await atualizarLogoSquad(snapshot.data);
                          },
                          child: CircleAvatar(
                            minRadius: 22,
                            maxRadius: 44,
                            backgroundImage: NetworkImage(
                              snapshot.data.urlImagem,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                          fit: FlexFit.loose,
                          child: Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            child: Text(
                              snapshot.data.titulo,
                              style: GoogleFonts.roboto(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  textStyle: TextStyle(color: Colors.white)),
                              maxLines: 2,
                            ),
                          )),
                    ],
                  ),
                ));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  atualizarLogoSquad(SquadModel squad) async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (image == null) return null;

    StorageUploadTask task =
        FirebaseStorage.instance.ref().child(squad.id).putFile(image);
    StorageTaskSnapshot taskSnapshot = await task.onComplete;
    String url = await taskSnapshot.ref.getDownloadURL();

    Firestore.instance
        .collection("squads")
        .document(squad.id)
        .updateData({"urlImagem": url});

    squad.urlImagem = url;
    squadBloc.adicionaSquad(squad);

    AppModule.to.getBloc<AppBloc>().loadCurrentUser();
  }
}
