import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:squadrum/app/shared/custom_drawer/custom_drawer_page.dart';

main() {
  testWidgets('CustomDrawerPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(CustomDrawerPage(title: 'CustomDrawer')));
    final titleFinder = find.text('CustomDrawer');
    expect(titleFinder, findsOneWidget);
  });
}
  