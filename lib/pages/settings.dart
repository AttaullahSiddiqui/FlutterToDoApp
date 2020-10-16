import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:practice/shared/styles.dart';

class FilterForm extends StatefulWidget {
  String singleValue;
  Function callback;

  FilterForm({Key key, this.singleValue, this.callback}) : super(key: key);

  @override
  _FilterFormState createState() => _FilterFormState();
}

class _FilterFormState extends State<FilterForm> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    List<String> radioValues = ["All", "Pending", "Completed"];

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          DropdownButtonFormField(
            value: widget.singleValue,
            decoration: AuthInputDecoration,
            items: radioValues.map((val) {
              return DropdownMenuItem(
                value: val,
                child: Text(val),
              );
            }).toList(),
            onChanged: (val) => setState(() => widget.singleValue = val),
          ),
          SizedBox(height: 30.0),
          OutlineButton(
            onPressed: () {
              Navigator.of(context).pop(widget.callback(widget.singleValue));
              Fluttertoast.showToast(msg: "List updated");
            },
            color: Colors.pink,
            borderSide: BorderSide(width: 3.0, color: Colors.pink),
            child: Text(
              "Apply",
              style: TextStyle(color: Colors.pink, fontSize: 16.0),
            ),
          )
        ],
      ),
    );
  }
}
