import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:squadrum/app/modules/home/resumo/novo_squad/novo_squad_bloc.dart';
import 'package:squadrum/app/modules/home/resumo/resumo_module.dart';

void main() {

  initModule(ResumoModule());
  NovoSquadBloc bloc;
  
  setUp(() {
      bloc = ResumoModule.to.bloc<NovoSquadBloc>();
  });

  group('NovoSquadBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<NovoSquadBloc>());
    });
  });

}
  