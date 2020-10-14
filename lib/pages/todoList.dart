import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
import 'package:practice/models/todo.dart';
import 'package:practice/pages/todosTile.dart';
// import 'package:practice/services/db.dart';
import 'package:provider/provider.dart';

class TodoList extends StatefulWidget {
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
        return TodoTile(todo: todos[index]);
      },
    );

    // return Container();
    // return StreamBuilder(
    //   stream: Database().allTodos,
    //   builder: (context, stream) {
    //     if (stream.connectionState == ConnectionState.waiting) {
    //       return Center(child: CircularProgressIndicator());
    //     }
    //     if (stream.hasError) {
    //       return Center(child: Text(stream.error.toString()));
    //     }
    //     QuerySnapshot querySnapshot = stream.data;
    //     return ListView.builder(
    //       itemCount: querySnapshot.size,
    //       itemBuilder: (context, index) {
    //         String dateFb = DateFormat.yMMMd().add_jm().format(
    //             new DateTime.fromMicrosecondsSinceEpoch(
    //                 querySnapshot.docs[index]['timestamp'] * 1000));
    //         return ListTile(
    //           title: Text(querySnapshot.docs[index]['todo']),
    //           subtitle: Text(dateFb),
    //         );
    //       },
    //     );
    //   },
    // );

    // final todos = Provider.of<QuerySnapshot>(context);
    // todos.docs.map((doc) => print(doc.data));

    // for (var doc in todos) {
    //   print(doc);
    // }
  }
}
