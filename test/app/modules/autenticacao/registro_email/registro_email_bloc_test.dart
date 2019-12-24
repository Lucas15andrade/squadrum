import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:squadrum/app/modules/autenticacao/registro_email/registro_email_bloc.dart';
import 'package:squadrum/app/modules/autenticacao/autenticacao_module.dart';

void main() {

  initModule(AutenticacaoModule());
  RegistroEmailBloc bloc;
  
  setUp(() {
      bloc = AutenticacaoModule.to.bloc<RegistroEmailBloc>();
  });

  group('RegistroEmailBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<RegistroEmailBloc>());
    });
  });

}
  