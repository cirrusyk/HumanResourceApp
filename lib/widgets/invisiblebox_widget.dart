import 'package:flutter/material.dart';

class InvisibleBox extends StatelessWidget {
  final double percentage;

  const InvisibleBox({Key? key, required this.percentage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * percentage,
    );
  }
}
