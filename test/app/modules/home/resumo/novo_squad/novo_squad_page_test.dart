import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:squadrum/app/modules/home/resumo/novo_squad/novo_squad_page.dart';

main() {
  testWidgets('NovoSquadPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(NovoSquadPage(title: 'NovoSquad')));
    final titleFinder = find.text('NovoSquad');
    expect(titleFinder, findsOneWidget);
  });
}
  