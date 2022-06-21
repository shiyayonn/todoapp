import 'dart:io';

import 'package:flutter/material.dart';

import '../utils/database_util.dart';

class IncompleteTodo extends StatefulWidget {
  const IncompleteTodo({
    super.key,
  });

  @override
  State<IncompleteTodo> createState() => _IncompleteTodoState();
}

class _IncompleteTodoState extends State<IncompleteTodo> {
  // All journals
  List<Map<String, dynamic>> _todos = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshTodos() async {
    final data = await SQLHelper.getTodos();
    print(data);
    setState(() {
      _todos = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_todos.toString()),
                  ElevatedButton(
                      onPressed: _refreshTodos
                      ,
                      child: Text("TEST"))
                ],
              ),
            ),
    );
  }
}
