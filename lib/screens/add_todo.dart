import 'dart:io';

import 'package:flutter/material.dart';

class AddTodo extends StatelessWidget {
  const AddTodo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Todo'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "Details"),
            ),
            TextFormField(
              enabled: false,
            ),
            ElevatedButton(onPressed: () => {}, child: const Icon(Icons.save)),
          ],
        ),
      ),
    );
  }
}
