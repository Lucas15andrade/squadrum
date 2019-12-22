import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:squadrum/app/modules/autenticacao/autenticacao_bloc.dart';
import 'package:squadrum/app/app_module.dart';

void main() {

  initModule(AppModule());
  AutenticacaoBloc bloc;
  
  setUp(() {
      bloc = AppModule.to.bloc<AutenticacaoBloc>();
  });

  group('AutenticacaoBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<AutenticacaoBloc>());
    });
  });

}
  