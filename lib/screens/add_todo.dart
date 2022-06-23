import 'package:flutter/material.dart';
import 'package:todoapp/utils/valididators.dart';
import '../utils/sql_helper.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({
    super.key,
  });

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  bool isValid = false;

  late SQLHelper sqlHelper;

  final _titleCtrl = TextEditingController();
  final _detailCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    sqlHelper = SQLHelper();
    sqlHelper.initDB().whenComplete(() async {
      setState(() {});
    });
  }

  Future<void> _onSaved() async {

    // Check if form is valid
    if (_formKey.currentState!.validate()) {
      await sqlHelper
          .createItem(_titleCtrl.text, _detailCtrl.text)
          .catchError((err) {

        // Display a snackbar if task already exist in the database
        if (err.toString().contains(
            "DatabaseException(UNIQUE constraint failed: todo.title, todo.details")) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                backgroundColor: Colors.red,
                content: Text('Task already exist')),
          );
        }
      });

      // Display a snackbar that tells us the task was succesfully added
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.green,
            content: Text('Succesfully added new Task')),
      );
    } 
    // If form is not valid, display a snackbar
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Please fill up all fields')),
      );
    }
  }

  _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                    decoration: const InputDecoration(labelText: "Title"),
                    controller: _titleCtrl,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: Validators.isEmpty),
                TextFormField(
                    decoration: const InputDecoration(labelText: "Details"),
                    controller: _detailCtrl,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: Validators.isEmpty),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                        onPressed: _onSaved,
                        label: const Text("Save task"),
                        icon: const Icon(Icons.save)),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton.icon(
                          onPressed: _cancel,
                          label: const Text("Cancel"),
                          icon: const Icon(Icons.cancel)),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
