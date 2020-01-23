import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:squadrum/app/modules/home/resumo/squad/membro/membro_page.dart';

main() {
  testWidgets('MembroPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(MembroPage()));
    final titleFinder = find.text('Membro');
    expect(titleFinder, findsOneWidget);
  });
}
  