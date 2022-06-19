import 'dart:io';

import 'package:flutter/material.dart';

class IncompleteTodo extends StatefulWidget {
  const IncompleteTodo({
    super.key,
  });

  @override
  State<IncompleteTodo> createState() => _IncompleteTodoState();
}

class _IncompleteTodoState extends State<IncompleteTodo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: ""),
            ),
            ],
        ),
      ),
    );
  }
}
