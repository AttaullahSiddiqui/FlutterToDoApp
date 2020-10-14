import 'package:flutter/material.dart';
import 'package:practice/shared/styles.dart';
// import 'package:group_radio_button/group_radio_button.dart';

class FilterForm extends StatefulWidget {
  String singleValue;
  Function callback;
  FilterForm({Key key, this.singleValue, this.callback}) : super(key: key);
  @override
  _FilterFormState createState() => _FilterFormState();
}

// String _selectedVal = "Pending";
// String _singleValue = s;

class _FilterFormState extends State<FilterForm> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    int _stackIndex = 0;
    // List<RadioModel> sampleData = new List<RadioModel>();

    List<String> radioValues = ["All", "Pending", "Completed"];

    return Form(
      key: _formKey,
      child: Column(
        // padding: EdgeInsets.only(left: 50.0),
        children: <Widget>[
          // Transform.scale(
          //   scale: 1.5,
          //   child: RadioGroup<String>.builder(
          //     groupValue: _selectedVal,
          //     onChanged: (value) => setState(() {
          //       _selectedVal = value;
          //       print(_selectedVal);
          //     }),
          //     items: radioValues,
          //     itemBuilder: (item) => RadioButtonBuilder(item),
          //   ),
          // ),
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
