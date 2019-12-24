import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:squadrum/app/modules/autenticacao/login_email/recupera_senha/recupera_senha_page.dart';

main() {
  testWidgets('RecuperaSenhaPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(RecuperaSenhaPage(title: 'RecuperaSenha')));
    final titleFinder = find.text('RecuperaSenha');
    expect(titleFinder, findsOneWidget);
  });
}
  