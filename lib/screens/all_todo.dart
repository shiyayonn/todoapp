import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../utils/sql_helper.dart';

class AllTodo extends StatefulWidget {
  const AllTodo({
    super.key,
  });

  @override
  State<AllTodo> createState() => AllTodoState();
}

class AllTodoState extends State<AllTodo> {
  List<Todo> _todos = [];

  late SQLHelper sqlHelper;
  bool _isLoading = true;

  // This function is used to fetch all data from the database
  void refreshTodos() async {
    setState(() {
      _isLoading = true;
    });

    final data = await sqlHelper.getAllTodoList();

    setState(() {
      _todos = data;
      _isLoading = false;
    });
  }

  void deleteItem(int id) async {
    await sqlHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      backgroundColor: Colors.green,
      content: Text('Task Deleted'),
    ));
    refreshTodos();
  }

  // fetch todo list on startup
  @override
  void initState() {
    super.initState();

    sqlHelper = SQLHelper();
    sqlHelper.initDB().whenComplete(() async {
      setState(() {
        refreshTodos();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        color: Colors.white,
        child: _todos.isEmpty
            ? const Center(child: Text("There are no task."))
            : ListView.builder(
                itemCount: _todos.length,
                itemBuilder: (context, index) => Card(
                  color: Colors.yellow[200],
                  margin: const EdgeInsets.all(5),
                  child: ListTile(
                    title: Text(_todos[index].title,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(_todos[index].details),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          Checkbox(
                              value:
                                  _todos[index].isCompleted == 1 ? true : false,
                              onChanged: (value) {
                              // Flip the value of the isCompleted column when we click on the checkbox
                                sqlHelper.updateTodoStatus(_todos[index].id,
                                    _todos[index].isCompleted == 1 ? 0 : 1);
                                setState(() {
                                  refreshTodos();
                                });
                              }),
                          IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => {
                                    deleteItem(_todos[index].id),
                                  }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
