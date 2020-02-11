import 'package:bloc_pattern/bloc_pattern_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:squadrum/app/modules/autenticacao/autenticacao_page.dart';

main() {
  testWidgets('AutenticacaoPage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(AutenticacaoPage()));
    final titleFinder = find.text('Autenticacao');
    expect(titleFinder, findsOneWidget);
  });
}
