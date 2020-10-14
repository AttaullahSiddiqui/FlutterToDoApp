import 'package:firebase_auth/firebase_auth.dart';
import 'package:practice/models/user.dart';
import 'package:practice/services/db.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserObject _userObjectFromFirebase(User user) {
    return user != null ? UserObject(uid: user.uid) : null;
  }

  Stream<UserObject> get user {
    return _auth
        .authStateChanges()
        // .map((User user) => _userObjectFromFirebase(user));
        .map(_userObjectFromFirebase);
  }

  Future signInAnonymous() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      Database(uid: user.uid);
      return _userObjectFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future createUserFunc(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      Database(uid: user.uid);
      return _userObjectFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailPass(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      print("User data from sign with email ");
      print(user.uid);
      // await Database(uid: user.uid).addNewTodo("Code in Flutter");
      Database(uid: user.uid);
      return _userObjectFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
