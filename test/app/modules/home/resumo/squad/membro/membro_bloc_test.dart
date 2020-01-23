import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:squadrum/app/modules/home/resumo/squad/membro/membro_bloc.dart';
import 'package:squadrum/app/modules/home/resumo/squad/squad_module.dart';

void main() {

  initModule(SquadModule());
  MembroBloc bloc;
  
  setUp(() {
      bloc = SquadModule.to.bloc<MembroBloc>();
  });

  group('MembroBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<MembroBloc>());
    });
  });

}
  