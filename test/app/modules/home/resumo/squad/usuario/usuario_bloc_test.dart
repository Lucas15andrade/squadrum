import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:squadrum/app/modules/home/resumo/squad/usuario/usuario_bloc.dart';
import 'package:squadrum/app/modules/home/resumo/squad/squad_module.dart';

void main() {

  initModule(SquadModule());
  UsuarioBloc bloc;
  
  setUp(() {
      bloc = SquadModule.to.bloc<UsuarioBloc>();
  });

  group('UsuarioBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<UsuarioBloc>());
    });
  });

}
  