import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:practice/services/auth.dart';

class Login extends StatefulWidget {
  final Function toggleView;
  Login({this.toggleView});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool checkEmail(txt) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(txt);
    return emailValid;
  }

  String error = '';
  String email = '';
  String pswd = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 75.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    RichText(
                        text: TextSpan(
                            text: "Welcome to ",
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.grey[500]),
                            children: [
                          TextSpan(
                              text: "Todo",
                              style: TextStyle(
                                  fontSize: 28.0,
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold))
                        ])),
                    SizedBox(height: 50.0),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.none,
                      decoration: InputDecoration(labelText: 'Enter email..'),
                      validator: (val) =>
                          val.isEmpty ? "Email is required" : null,
                      onChanged: (val) {
                        setState(() => email = val.toLowerCase().trim());
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Enter Password..'),
                      validator: (val) =>
                          val.length < 6 ? "Password is too short" : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => pswd = val);
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      color: Colors.pink,
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          if (!checkEmail(email)) {
                            setState(() => error = "Invalid Email");
                            return;
                          }
                          setState(() => error = "");
                          dynamic result =
                              await _auth.signInWithEmailPass(email, pswd);
                          if (result == null) {
                            setState(
                                () => error = "Please provide a valid email");
                          } else {
                            print('User registered successfully');
                            print(result.uid);
                          }
                        }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(7.0),
                      child: Text(error, style: TextStyle(color: Colors.red)),
                    ),
                    SizedBox(
                      height: 30.0,
                      child: OutlineButton(
                        child: Text(
                          "Sign In as Anonymous",
                          style: TextStyle(color: Colors.purple),
                        ),
                        onPressed: () async {
                          dynamic result = await _auth.signInAnonymous();
                          if (result == null) {
                            print('error signing in');
                          } else {
                            print('signed in');
                            print(result.uid);
                          }
                        },
                      ),
                    ),
                    OutlineButton(
                      child: Text(
                        "Go To Register",
                        style: TextStyle(color: Colors.pink),
                      ),
                      onPressed: () => widget.toggleView(),
                    )
                  ],
                ),
              ),
            )
            // child: RaisedButton(
            //   shape:
            //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            //   child: Text(
            //     'Sign In as Anonymous',
            //     style: TextStyle(color: Colors.white, fontSize: 16.0),
            //   ),
            //   color: Colors.pink,
            //   onPressed: () async {
            //     dynamic result = await _auth.signInAnonymous();
            //     if (result == null) {
            //       print('error signing in');
            //     } else {
            //       print('signed in');
            //       print(result.uid);
            //     }
            //   },
            // ),
            ),
      ),
    );
  }
}
