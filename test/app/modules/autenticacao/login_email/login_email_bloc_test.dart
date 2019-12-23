import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:squadrum/app/modules/autenticacao/login_email/login_email_bloc.dart';
import 'package:squadrum/app/modules/autenticacao/autenticacao_module.dart';

void main() {

  initModule(AutenticacaoModule());
  LoginEmailBloc bloc;
  
  setUp(() {
      bloc = AutenticacaoModule.to.bloc<LoginEmailBloc>();
  });

  group('LoginEmailBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<LoginEmailBloc>());
    });
  });

}
  