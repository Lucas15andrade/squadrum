import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:squadrum/app/modules/home/resumo/resumo_page.dart';

main() {
  testWidgets('ResumoPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(ResumoPage(title: 'Resumo')));
    final titleFinder = find.text('Resumo');
    expect(titleFinder, findsOneWidget);
  });
}
  