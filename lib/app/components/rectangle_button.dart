import 'package:flutter/material.dart';

class RectangleButton extends StatelessWidget {
  RectangleButton(
      {required this.label, required this.onPressed, required this.icon});

  final String label;
  final Function() onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(15),
            textStyle: const TextStyle(fontSize: 20),
            primary: Colors.red,
          ),
          onPressed: onPressed,
          label: Text(label),
          icon: Icon(icon),
        ),
      ),
    );
  }
}
