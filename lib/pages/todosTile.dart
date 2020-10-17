import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practice/models/todo.dart';
import 'package:practice/services/db.dart';

//ignore: must_be_immutable
class TodoTile extends StatelessWidget {
  final Todo todo;
  final filterVal;
  TodoTile({this.todo, this.filterVal});
  bool trigger = false;

  @override
  Widget build(BuildContext context) {
    updateCompleteStatus(bool chng) => Database().editTodo(todo.todoID, chng);
    deleteTodo() => Database().deleteTodo(todo.todoID);

    final popUpMenu = PopupMenuButton(
      onSelected: (result) {
        if (result == 'delete')
          deleteTodo();
        else if (result == 'completed')
          updateCompleteStatus(true);
        else if (result == 'pending') updateCompleteStatus(false);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        todo.completed == false
            ? PopupMenuItem(
                value: "completed",
                child: Text('Mark as Completed'),
              )
            : const PopupMenuItem(
                value: "pending",
                child: Text('Mark as Pending'),
              ),
        const PopupMenuItem(
          value: "delete",
          child: Text('Delete'),
        ),
      ],
    );

    switch (filterVal) {
      case "All":
        trigger = true;
        break;
      case "Pending":
        if (todo.completed == false) trigger = true;
        break;
      case "Completed":
        if (todo.completed) trigger = true;
        break;
    }
    String todoTime = DateFormat.yMMMd()
        .add_jm()
        .format(new DateTime.fromMicrosecondsSinceEpoch(todo.timestamp * 1000));
    return trigger == true
        ? Padding(
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
                subtitle: Text(todoTime),
                trailing: popUpMenu,
              ),
            ),
          )
        : Container();
  }
}
