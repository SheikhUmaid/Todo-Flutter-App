// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace,

import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';

class TodoTile extends StatelessWidget {
  // late Todo todo;

  const TodoTile({super.key, todo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Container(
        width: double.infinity,
        child: Card(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'todo.title',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.delete_forever,
                          color: Colors.white,
                        )),
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'todo.desc',
                  style: TextStyle(
                      color: Colors.white24,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
