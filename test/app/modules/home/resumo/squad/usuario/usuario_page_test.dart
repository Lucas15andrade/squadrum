import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:squadrum/app/modules/home/resumo/squad/usuario/usuario_page.dart';

main() {
  testWidgets('UsuarioPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(UsuarioPage(title: 'Usuario')));
    final titleFinder = find.text('Usuario');
    expect(titleFinder, findsOneWidget);
  });
}
  