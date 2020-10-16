import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:practice/models/todo.dart';

class Database {
  final String uid;
  Database({this.uid});

  final CollectionReference toDoCollection =
      FirebaseFirestore.instance.collection("todos");

  Future addNewTodo(String todo) async {
    String userId = await getUid();
    return await toDoCollection.add({
      'todo': todo,
      'completed': false,
      "uid": userId,
      'timestamp': DateTime.now().toUtc().millisecondsSinceEpoch
    });
  }

  getUid() {
    final User user = FirebaseAuth.instance.currentUser;
    return user.uid;
  }

  Future editTodo(String todoID, bool completed) async {
    return await toDoCollection
        .doc(todoID)
        .update({'completed': completed}).then((result) {
      Fluttertoast.showToast(msg: "Todo updated successfully");
      // print("Todo updated successfully");
    }).catchError((onError) {
      Fluttertoast.showToast(msg: "Error updating Todo");
      // print("Error updating Todo");
    });
  }

  Future deleteTodo(String todoID) async {
    return await toDoCollection.doc(todoID).delete();
  }

  Stream<List<Todo>> get allTodos {
    String userId = getUid();
    return toDoCollection
        .orderBy('timestamp')
        .where('uid', isEqualTo: userId)
        .snapshots()
        .map(todoListSnapshot);
  }

  List<Todo> todoListSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Todo(
          todo: doc.data()['todo'] ?? '',
          completed: doc.data()['completed'] ?? false,
          uid: doc.data()['uid'] ?? '0',
          timestamp: doc.data()['timestamp'] ?? '0',
          todoID: doc.id);
    }).toList();
  }
}
