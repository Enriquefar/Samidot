import 'package:flutter_test/flutter_test.dart';
import 'package:mao_na_massa/main.dart';

void main() {
  testWidgets('recusa consulta vazia', (tester) async {
    await tester.pumpWidget(const MaoNaMassaApp());

    await tester.tap(find.text('Pesquisar'));
    await tester.pump();

    expect(find.textContaining('Digite o nome de uma receita'), findsOneWidget);
    expect(find.textContaining('Pesquisando por'), findsNothing);
  });

  testWidgets('recusa consulta só com espaços', (tester) async {
    await tester.pumpWidget(const MaoNaMassaApp());

    await tester.enterText(find.byType(TextFormField), '   ');
    await tester.tap(find.text('Pesquisar'));
    await tester.pump();

    expect(find.textContaining('Digite o nome de uma receita'), findsOneWidget);
    expect(find.textContaining('Pesquisando por'), findsNothing);
  });

  testWidgets('aceita consulta válida e trata os espaços', (tester) async {
    await tester.pumpWidget(const MaoNaMassaApp());

    await tester.enterText(find.byType(TextFormField), '  bolo   de cenoura  ');
    await tester.tap(find.text('Pesquisar'));
    await tester.pump();

    expect(find.text('Pesquisando por: "bolo de cenoura"'), findsOneWidget);
    expect(find.textContaining('Digite o nome de uma receita'), findsNothing);
  });
}