import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practice/models/todo.dart';
import 'package:practice/pages/settings.dart';
import 'package:practice/pages/todoList.dart';
import 'package:practice/services/auth.dart';
import 'package:practice/services/db.dart';
import 'package:provider/provider.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AuthService _auth = AuthService();
  String todo;
  String createdAt;
  String filterVal = "All";
  CollectionReference users = FirebaseFirestore.instance.collection('todos');

  Future<void> addUser() {
    return users
        .add({
          'todo': 'todo',
          'createdAt': 'company',
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  final myController = TextEditingController();
  final myController2 = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void _showSettingsModal() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              child: Column(
                children: [
                  Text(
                    "Select an Option:",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  FilterForm(
                      singleValue: filterVal,
                      callback: (val) => setState(() {
                            filterVal = val;
                            print(filterVal);
                          })),
                ],
              ));
        });
  }

  void presentDialog(String exc) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Alert Dialog"),
          content: Text(exc),
        );
      },
    );
  }

  void customDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 230,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('Add New ToDo',
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              decoration: TextDecoration.underline)),
                    ),
                    SizedBox(height: 12.0),
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: TextField(
                        controller: myController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type here....",
                            hintStyle: TextStyle(fontSize: 18.0)),
                      ),
                    ),
                    SizedBox(
                      width: 200.0,
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () async {
                          if (myController.text.trim().isEmpty) return;
                          dynamic addResult =
                              await Database().addNewTodo(myController.text);
                          if (addResult == null) {
                            print("Error adding new Todo");
                          } else {
                            print("Congratulations");
                            Navigator.pop(context);
                            myController.clear();
                          }
                        },
                        child: Text(
                          "Add",
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                        color: Colors.pink,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Todo>>.value(
      value: Database().allTodos,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
              title: Container(
                  alignment: Alignment.center, child: Text(widget.title)),
              actions: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.settings_outlined,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    onPressed: () => _showSettingsModal()),
                IconButton(
                    icon: Icon(
                      Icons.exit_to_app_rounded,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    onPressed: () async {
                      await _auth.signOut();
                    })
              ]),
          body: Center(child: TodoList(singleValue: filterVal)),
          floatingActionButton: FloatingActionButton(
            onPressed: customDialog,
            tooltip: 'Add Todo',
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
