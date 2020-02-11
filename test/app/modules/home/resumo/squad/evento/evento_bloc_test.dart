import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:squadrum/app/modules/home/resumo/squad/evento/evento_bloc.dart';
import 'package:squadrum/app/modules/home/resumo/squad/squad_module.dart';

void main() {

  initModule(SquadModule());
  EventoBloc bloc;
  
  setUp(() {
      bloc = SquadModule.to.bloc<EventoBloc>();
  });

  group('EventoBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<EventoBloc>());
    });
  });

}
  