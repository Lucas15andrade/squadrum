import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/subjects.dart';
import 'package:squadrum/app/shared/models/squad_model.dart';

class SquadBloc extends BlocBase {

  SquadModel squad;

  BehaviorSubject<SquadModel> _squadController = BehaviorSubject();

  Stream get squadOut => _squadController.stream;
  Sink get squadIn => _squadController.sink;


  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    _squadController.close();
    /* _usuarioController.close(); */
    super.dispose();
  }

  adicionaSquad(SquadModel squad){
    this.squad = squad;
    squadIn.add(squad);
  }

}
  