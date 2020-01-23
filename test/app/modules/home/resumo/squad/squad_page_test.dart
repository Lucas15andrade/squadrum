import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:squadrum/app/modules/home/resumo/squad/squad_page.dart';

main() {
  testWidgets('SquadPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(SquadPage()));
    final titleFinder = find.text('Squad');
    expect(titleFinder, findsOneWidget);
  });
}
  