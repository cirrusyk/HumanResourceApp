import 'package:flutter/material.dart';

class PrimaryActionButton extends StatelessWidget {
  final void Function() action;

  final String text;

  const PrimaryActionButton(
      {Key? key, required this.action, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: action,
        child: Text(text),
      ),
    );
  }
}
