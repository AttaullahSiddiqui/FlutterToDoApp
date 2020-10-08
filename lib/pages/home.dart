import 'dart:ui';

import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practice/services/auth.dart';

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
  CollectionReference users = FirebaseFirestore.instance.collection('todos');

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'todo': 'todo',
          'createdAt': 'company',
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  int _counter = 0;
  // String _dummyTxt = "xxxx";
  final myController = TextEditingController();
  final myController2 = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  void getString() {
    // presentDialog(myController.text);
    // setState(() {
    //   _dummyTxt = myController.text;
    // });
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
                        // onPressed: () {},
                        onPressed: addUser,
                        child: Text(
                          "Add",
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                        color: Colors.pink,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        // color: const Color(0xFF1BC0C5),
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Container(
                alignment: Alignment.center, child: Text(widget.title)),
            actions: <Widget>[
              FlatButton.icon(
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Logout",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    await _auth.signOut();
                  })
            ]),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
              Divider(
                color: Colors.green,
              ),
              Text(
                'Huurrraahhhh....I have learnt Flutter',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline2,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          // onPressed: _incrementCounter,
          onPressed: customDialog,
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
