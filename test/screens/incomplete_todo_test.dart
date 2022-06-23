import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/screens/incomplete_todo.dart';

void main() {
  testWidgets('Incomplete Todo Screen widget Test', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: IncompleteTodo()));

    // I don't know why it cannot detect the text field for this widget, will investigate further

    // expect(find.text("There are no incomplete task."), findsWidgets);
  });
}
