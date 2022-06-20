import 'dart:io';

import 'package:flutter/material.dart';

class CompleteTodo extends StatefulWidget {
  const CompleteTodo({
    super.key,
  });

  @override
  State<CompleteTodo> createState() => _CompleteTodoState();
}

class _CompleteTodoState extends State<CompleteTodo> {
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
              decoration: const InputDecoration(labelText: "asdad"),
            ),
          ],
        ),
      ),
    );
  }
}
