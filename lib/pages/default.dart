import 'package:flutter/material.dart';
import 'package:practice/pages/login.dart';
import 'package:practice/pages/register.dart';

class Default extends StatefulWidget {
  @override
  _DefaultState createState() => _DefaultState();
}

class _DefaultState extends State<Default> {
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn)
      return Login(toggleView: toggleView);
    else
      return Register(toggleView: toggleView);
  }
}
