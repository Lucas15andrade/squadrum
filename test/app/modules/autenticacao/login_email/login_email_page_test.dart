import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:squadrum/app/modules/autenticacao/login_email/login_email_page.dart';

main() {
  testWidgets('LoginEmailPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(LoginEmailPage(title: 'LoginEmail')));
    final titleFinder = find.text('LoginEmail');
    expect(titleFinder, findsOneWidget);
  });
}
  