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
  bool adding = false;
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
              id: todoJson['id'].toString(),
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
    super.initState();
    debugPrint('initState called');
    fetchTodos();
    debugPrint('initState end');
  }

  deleteTodo(String id) async {
    debugPrint('deleteTodo called');
    String url = 'http://192.168.42.236:8000/api/$id/';
    debugPrint(url);
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode == 204) {
      // rebuild the screen
      setState(() {
        todos = [];
        fetchTodos();
      });
    } else {
      throw Exception('Failed to delete todo');
    }
  }

  addTodo() async {
    debugPrint('addTodo called');
    String url = 'http://192.168.42.236:8000/api/';
    debugPrint(url);
    final response = await http.post(Uri.parse(url),
        body: jsonEncode(<String, dynamic>{
          'title': 'title',
          'description': 'description',
          'completed': false,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 201) {
      // rebuild the screen
      setState(() {
        todos = [];
        fetchTodos();
      });
    } else {
      throw Exception('Failed to add todo');
    }
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
        children: todos
            .map((todo) => TodoTile(
                  todo: todo,
                  deleteTodo: () => deleteTodo(todo.id),
                ))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          debugPrint(todos.toString());
          setState(() => addTodo());
        },
        tooltip: 'Add Todo',
      ),
    );
  }
}
