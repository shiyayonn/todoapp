import 'dart:io';

import 'package:flutter/material.dart';

class ArchivedTodo extends StatefulWidget {
  const ArchivedTodo({
    super.key,
  });

  @override
  State<ArchivedTodo> createState() => _ArchivedTodoState();
}

class _ArchivedTodoState extends State<ArchivedTodo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "incomplete"),
            ),
          ],
        ),
      ),
    );
  }
}
