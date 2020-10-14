import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practice/models/todo.dart';

class Database {
  final String uid;
  Database({this.uid});

  final CollectionReference toDoCollection =
      FirebaseFirestore.instance.collection("todos");

  Future addNewTodo(String todo) async {
    String userId = await getUid();
    print(userId);
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

  Stream<List<Todo>> get allTodos {
    String userId = getUid();
    return toDoCollection
        .where('uid', isEqualTo: userId)
        .snapshots()
        .map(todoListSnapshot);
  }

  List<Todo> todoListSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Todo(
          todo: doc.data()['todo'] ?? '',
          completed: doc.data()['completed'] ?? false,
          uid: doc.data()['uid'] ?? '0');
    }).toList();
  }

  // Future<DocumentSnapshot> getTodos() async {
  //   String userId = getUid();
  //   return await toDoCollection.doc(userId).get();
  // }

  // Future<void> getTodos() async {
  //   QuerySnapshot querySnapshot = await toDoCollection.get();

  //   print('###########s result ${querySnapshot.docs}');

  //   if (querySnapshot != null) {
  //     for (int i = 0; i < querySnapshot.docs.length; i++) {
  //       var a = querySnapshot.docs[i];
  //       print(a.id);
  //     }
  //   }
  // }
}
