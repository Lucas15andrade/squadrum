import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/subjects.dart';
import 'package:squadrum/app/services/firebase_service.dart';
import 'package:squadrum/app/shared/enums/status.dart';
import 'package:squadrum/app/shared/models/retorno.dart';
import 'package:squadrum/app/shared/models/usuario_model.dart';

class MembroBloc extends BlocBase {
  BehaviorSubject<Retorno> _usuarioController =
      BehaviorSubject.seeded(Retorno(status: Status.VAZIO));

  Stream get usuarioOut => _usuarioController.stream;
  Sink get usuarioIn => _usuarioController.sink;

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _usuarioController.close();
    super.dispose();
  }

  void pesquisaNickname(String nome) async {
    String uid;
    UsuarioModel usuario;

    if (nome.trim().length > 0) {
      uid = await FirebaseService.pesquisaNickname(nome);
    }

    if (uid != null) {
      await Firestore.instance
          .collection("usuarios")
          .document(uid)
          .get()
          .then((DocumentSnapshot ds) async {
        if (ds.data != null) {
          usuario = UsuarioModel.fromDocument(ds);
          usuario.squads =
              await FirebaseService.carregaSquads(ds.data["squads"]);
        }
      });
      //usuarioIn.add(usuario);
      usuarioIn.add(Retorno(object: usuario, status: Status.SUCESSO));
    } else {
      //usuarioIn.add(null);
      usuarioIn.add(Retorno(status: Status.ERRO));
    }
  }

  Future<Null> adicionarUsuario(UsuarioModel usuario) async {
    //await FirebaseService.adicionarMembro(usuario);
    usuarioIn.add(Retorno(status: Status.CARREGANDO));
    await Future.delayed(Duration(seconds: 3));
    usuarioIn.add(Retorno(status: Status.CONCLUIDO));
  }
}
