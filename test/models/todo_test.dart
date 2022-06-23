// Import the test package and Counter class
import 'package:test/test.dart';
import 'package:todoapp/models/todo.dart';

void main() {

  final todo = Todo(1, 0, "Test", "Test Details", "2022-06-23 13:16:10");
    final todoMap = {
      "id": 1,
      "isCompleted": 0,
      "title": "Test",
      "details": "Test Details",
      "dateCreated": "2022-06-23 13:16:10"
    };
    final todoFromMapObject = Todo.fromMapObject(todoMap);

  test("Should return valid map", () {   
    expect(todo.toMap(), todoMap);
  });

  test("Should return valid Todo from Map", () {
    expect(todo.id, todoFromMapObject.id);
    expect(todo.isCompleted, todoFromMapObject.isCompleted);
    expect(todo.title, todoFromMapObject.title);
    expect(todo.details, todoFromMapObject.details);
    expect(todo.dateCreated, todoFromMapObject.dateCreated);
  });
}
