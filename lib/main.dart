import 'package:flutter/material.dart';
import 'package:todoapp/screens/add_todo.dart';
import 'package:todoapp/screens/archived_todo.dart';
import 'package:todoapp/screens/complete_todo.dart';
import 'package:todoapp/screens/incomplete_todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tuh Duh',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Tuh Duh'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
  IncompleteTodo(),
  CompleteTodo(),
 // ArchivedTodo(),
  
];
  void _addTodo() {
    Navigator.push(
      context,
      MaterialPageRoute(
          // haBs an error if you put on const
          builder: (context) => const AddTodo()),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.task_outlined),
            label: 'Incomplete',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Completed',
          ),
       /*    BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: 'Archived Task',
          ), */
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        tooltip: 'Increment',
        child: const Icon(Icons.add_task),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
