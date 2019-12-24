import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:squadrum/app/modules/autenticacao/registro_email/registro_email_page.dart';

main() {
  testWidgets('RegistroEmailPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(RegistroEmailPage(title: 'RegistroEmail')));
    final titleFinder = find.text('RegistroEmail');
    expect(titleFinder, findsOneWidget);
  });
}
  