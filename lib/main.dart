import 'package:flutter/material.dart';
import 'package:todoapp/screens/add_todo.dart';
import 'package:todoapp/screens/all_todo.dart';
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

GlobalKey<AllTodoState> globalKey1 = GlobalKey<AllTodoState>();
GlobalKey<IncompleteTodoState> globalKey2 = GlobalKey<IncompleteTodoState>();
GlobalKey<CompleteTodoState> globalKey3 = GlobalKey<CompleteTodoState>();

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[
    AllTodo(key:globalKey1),
    IncompleteTodo(key: globalKey2),
    CompleteTodo(key:globalKey3),
    // ArchivedTodo(),
  ];
  void _addTodo() {
    Navigator.push(
      context,
      MaterialPageRoute(
          // haBs an error if you put on const
          builder: (context) => const AddTodo()),
    ).then((value) {
      globalKey1.currentState?.refreshTodos();
      globalKey2.currentState?.refreshTodos();
      globalKey3.currentState?.refreshTodos();
    });
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
            icon: Icon(Icons.list),
            label: 'All',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_outlined),
            label: 'Incomplete',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Completed',
          ),
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
