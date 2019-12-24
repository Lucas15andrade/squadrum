import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:squadrum/app/modules/autenticacao/login_email/recupera_senha/recupera_senha_bloc.dart';
import 'package:squadrum/app/modules/autenticacao/login_email/login_email_module.dart';

void main() {

  initModule(LoginEmailModule());
  RecuperaSenhaBloc bloc;
  
  setUp(() {
      bloc = LoginEmailModule.to.bloc<RecuperaSenhaBloc>();
  });

  group('RecuperaSenhaBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<RecuperaSenhaBloc>());
    });
  });

}
  