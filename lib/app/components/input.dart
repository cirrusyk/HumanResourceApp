import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  Input(
      {required this.labelText,
      required this.type,
      required this.onChanged,
      required this.hintText,
      required this.myController});
  final TextEditingController myController;
  final String labelText;
  final TextInputType type;
  final Function(String) onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: TextFormField(
        controller: myController,
        maxLength: 30,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
          ),
          labelStyle: TextStyle(
            color: Colors.redAccent,
            fontSize: 20,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        keyboardType: type,
        onChanged: onChanged,
        style: TextStyle(
          fontSize: 25,
        ),
      ),
    );
  }
}
