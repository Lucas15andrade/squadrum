import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:squadrum/app/modules/resumo/resumo_bloc.dart';
import 'package:squadrum/app/app_module.dart';

void main() {

  initModule(AppModule());
  ResumoBloc bloc;
  
  setUp(() {
      bloc = AppModule.to.bloc<ResumoBloc>();
  });

  group('ResumoBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<ResumoBloc>());
    });
  });

}
  