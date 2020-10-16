import 'package:flutter/material.dart';
import 'package:practice/models/todo.dart';
import 'package:practice/pages/todosTile.dart';
import 'package:provider/provider.dart';

class TodoList extends StatefulWidget {
  String singleValue;
  TodoList({Key key, this.singleValue}) : super(key: key);
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    final todos = Provider.of<List<Todo>>(context) ?? [];

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return TodoTile(todo: todos[index], filterVal: widget.singleValue);
      },
    );
  }
}
