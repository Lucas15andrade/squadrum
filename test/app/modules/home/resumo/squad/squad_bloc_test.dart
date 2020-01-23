import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:squadrum/app/modules/home/resumo/squad/squad_bloc.dart';
import 'package:squadrum/app/modules/home/resumo/resumo_module.dart';

void main() {

  initModule(ResumoModule());
  SquadBloc bloc;
  
  setUp(() {
      bloc = ResumoModule.to.bloc<SquadBloc>();
  });

  group('SquadBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<SquadBloc>());
    });
  });

}
  