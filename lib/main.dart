import 'package:flutter/material.dart';
import 'package:practice/models/user.dart';
import 'package:practice/pages/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:practice/services/auth.dart';
// import 'package:practice/shared/loaders.dart';
import 'package:provider/provider.dart';

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     theme: ThemeData(
//         primarySwatch: Colors.pink,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//         fontFamily: 'Roboto'),
//     home: Wrapper(),
//   ));
// }

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Error in initializing");
          return Container(width: 0.0, height: 0.0);
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<UserObject>.value(
            value: AuthService().user,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  primarySwatch: Colors.pink,
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  fontFamily: 'Roboto'),
              home: Wrapper(),
            ),
          );
        }
        return Container(width: 0.0, height: 0.0);
      },
    );
  }
}

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   final Future<FirebaseApp> _initialization = Firebase.initializeApp();
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       // Initialize FlutterFire:
//       future: _initialization,
//       builder: (context, snapshot) {
//         // Check for errors
//         if (snapshot.hasError) {
//           return null;
//         }
//         if (snapshot.connectionState == ConnectionState.done) {
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             theme: ThemeData(
//                 primarySwatch: Colors.pink,
//                 visualDensity: VisualDensity.adaptivePlatformDensity,
//                 fontFamily: 'Roboto'),
//             // home: MyHomePage(title: 'Todooo App'),
//             home: Login(),
//           );
//         }
//         return null;
//       },
//     );
//   }
// }
