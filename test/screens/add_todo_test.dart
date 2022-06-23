import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/screens/add_todo.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('Add Todo Screen widget Test', (tester) async {
    // Create the widget by telling the tester to build it.
    await tester.pumpWidget(const MaterialApp(home: AddTodo()));

    final titleTextField = find.text("Title");
    final detailField = find.text("Details");

    // There should only be two text fields in this screen
    expect(find.byType(TextField), findsNWidgets(2));
    expect(titleTextField, findsOneWidget);
    expect(detailField, findsOneWidget);

    // There should only be two elevated button in this screen
    expect(find.byIcon(Icons.save), findsOneWidget);
    expect(find.byIcon(Icons.cancel), findsOneWidget);

    /*  a Snackbar should appear when we click on the save button without populating 
        title textfield and details textfield                                   */
    await tester.tap(find.byIcon(Icons.save));
    expect(find.text('Please fill up all fields'), findsNothing);
    await tester.pump();
    expect(find.text('Please fill up all fields'), findsOneWidget);

    
  });
}
