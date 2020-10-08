import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:practice/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool checkEmail(txt) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(txt);
    return emailValid;
  }

  String email = '';
  String pswd = '';
  String error = '';

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
                    Text("Register"),
                    SizedBox(height: 20.0),
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
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          if (!checkEmail(email)) {
                            setState(() => error = "Invalid Email");
                            return;
                          }
                          setState(() => error = "");
                          print(email + 'xxxx');
                          print(pswd + 'xxxx');
                          dynamic result =
                              await _auth.createUserFunc(email, pswd);
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
                    OutlineButton(
                      child: Text(
                        "Back to Login",
                        style: TextStyle(color: Colors.purple),
                      ),
                      onPressed: () => widget.toggleView(),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
