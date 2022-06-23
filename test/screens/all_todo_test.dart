import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/screens/all_todo.dart';

void main() {
  testWidgets('All Todo Screen widget Test', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: AllTodo()));

    // ran out of time completing the widget tests
    final noTaskText = find.text("There are no task.");
    expect(noTaskText, findsOneWidget);
    
  });
}
