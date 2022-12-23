import 'package:flutter/material.dart';
import 'widgets/todo_tile.dart';
import 'models/todo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  List<Todo> todos = [];

  fetchTodos() async {
    debugPrint('fetchTodos called');
    final response =
        await http.get(Uri.parse('http://192.168.42.236:8000/api/'));
    debugPrint('fetchTodos end');
    if (response.statusCode == 200) {
      final todosJson = jsonDecode(response.body) as List;
      print(todosJson);
      setState(() {
        for (var todoJson in todosJson) {
          todos.add(Todo(
              title: todoJson['title'],
              desc: todoJson['description'],
              isDone: todoJson['completed']));
        }
      });
    } else {
      throw Exception('Failed to load todos');
    }
  }

  @override
  void initState() {
    debugPrint('initState called');
    super.initState();
    fetchTodos();
    debugPrint('initState end');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Todo With Django',
          style: TextStyle(color: Color.fromARGB(255, 72, 52, 52)),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        children: todos.map((todo) => TodoTile(todo: todo)).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          debugPrint(todos.toString());
        },
        tooltip: 'Add Todo',
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
