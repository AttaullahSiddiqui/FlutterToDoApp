import 'package:flutter/material.dart';
import 'package:practice/models/todo.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;
  TodoTile({this.todo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.pink,
              backgroundImage: AssetImage('assets/images/aa.png'),
            ),
            title: Text(todo.todo),
            subtitle: Text("hahaha"),
            trailing: Icon(Icons.more_vert)),
      ),
    );
  }
}
