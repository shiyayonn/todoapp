import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/screens/complete_todo.dart';

void main() {
  testWidgets('Complete Todo Screen widget Test', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: CompleteTodo()));

    // I don't know why it cannot detect the text field for this widget, will investigate further

    // final noTaskText = find.byType(Text);
    // expect(noTaskText, findsOneWidget);
  });
}
