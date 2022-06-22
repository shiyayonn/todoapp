import 'package:flutter/material.dart';

import '../utils/sql_helper.dart';

class CompleteTodo extends StatefulWidget {
  const CompleteTodo({
    super.key,
  });

  @override
  State<CompleteTodo> createState() => CompleteTodoState();
}

class CompleteTodoState extends State<CompleteTodo> {
  List<Map<String, dynamic>> _todos = [];

  late SQLHelper sqlHelper;
  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void refreshTodos() async {

    setState(() {
      _isLoading = true;
    });
    final data = await sqlHelper.getCompleteTodos();

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
  
  @override
  void initState() {
    super.initState();

    sqlHelper = SQLHelper();
    sqlHelper.initDB().whenComplete(() async {
      setState(() {
        refreshTodos();
      });
    });

    Future.delayed(Duration.zero, () async {});
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              color: Colors.white,
              child:
              _todos.isEmpty
                  ? const Center(child: Text("There are no complete task."))
                  : 
               ListView.builder(
                itemCount: _todos.length,
                itemBuilder: (context, index) => Card(
                  color: Colors.yellow[200],
                  margin: const EdgeInsets.all(5),
                  child: ListTile(
                    title: Text(_todos[index]['title'],
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(_todos[index]['details']),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          Checkbox(
                              value: _todos[index]['isCompleted'] == 1
                                  ? true
                                  : false,
                              onChanged: (value) {
                                sqlHelper.updateTodoStatus(_todos[index]['id'],
                                    _todos[index]['isCompleted'] == 1 ? 0 : 1);
                                setState(() {
                                  refreshTodos();
                                });
                              }
                              //_showForm(_journals[index]['id']),
                              ),
                          IconButton(
                              icon: const Icon(Icons.delete),
                               onPressed: () => {
                                          deleteItem(_todos[index]['id']),
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
