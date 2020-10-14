import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final String todo;
  final String uid;
  // final Timestamp timestamp;
  final bool completed;

  Todo({this.todo, this.completed, this.uid});
}
