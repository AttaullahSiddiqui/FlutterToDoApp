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

    print(todos);

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return TodoTile(todo: todos[index], filterVal: widget.singleValue);
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
