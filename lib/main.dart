import 'package:flutter/material.dart';
import 'widgets/todo_tile.dart';
import 'models/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Todo todo =
      Todo(title: 'Goto gym', desc: 'Going to gym is nessessary', isDone: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Todo With Django',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          TodoTile(todo: todo),
          TodoTile(todo: todo),
          TodoTile(todo: todo),
          TodoTile(todo: todo),
          TodoTile(todo: todo),
          TodoTile(todo: todo),
          TodoTile(todo: todo),
          TodoTile(todo: todo),
          TodoTile(todo: todo),
          TodoTile(todo: todo),
          TodoTile(todo: todo),
          TodoTile(todo: todo),
          TodoTile(todo: todo),
          TodoTile(todo: todo),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: _incrementCounter,
        tooltip: 'Add Todo',
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
