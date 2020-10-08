import 'package:flutter/material.dart';
import 'package:practice/models/user.dart';
import 'package:practice/pages/default.dart';
import 'package:practice/pages/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserObject>(context);

    print(user);

    if (user != null)
      return MyHomePage(title: "Todo App");
    else
      return Default();
  }
}
