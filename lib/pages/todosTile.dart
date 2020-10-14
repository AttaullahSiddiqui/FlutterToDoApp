import 'package:flutter/material.dart';
import 'package:practice/models/todo.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;
  final filterVal;
  TodoTile({this.todo, this.filterVal});
  bool trigger = false;
  var _tapposition;

  @override
  Widget build(BuildContext context) {
    _showCustomMenu() {
      final RenderBox overlay = Overlay.of(context).context.findRenderObject();
      showMenu(
          context: context,
          position: new RelativeRect.fromRect(
              _tapposition & Size(40, 40), Offset.zero & overlay.size),
          items: <PopupMenuItem<String>>[
            const PopupMenuItem<String>(
                child: Text('Mark as Completed'), value: 'Mark as Completed'),
            const PopupMenuItem<String>(child: Text('Delete'), value: 'Delete'),
          ]);
    }

    void _storePosition(TapDownDetails details) {
      _tapposition = details.globalPosition;
    }

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
                subtitle: Text("hahaha"),
                trailing: new GestureDetector(
                    child: Icon(Icons.more_vert),
                    onTap: () => _showCustomMenu(),
                    onTapDown: _storePosition),
              ),
            ),
          )
        : Container();
  }
}
