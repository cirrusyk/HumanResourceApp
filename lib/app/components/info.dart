import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  Info(
      {required this.value,
      required this.label,
      required this.onPressed,
      required this.myController});
  final String value;
  final String label;
  final Function() onPressed;
  final TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Enter new value'),
          content: TextFormField(
            controller: myController,
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: onPressed,
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.redAccent, fontSize: 18),
              ),
              style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all<Color>(Colors.redAccent),
              ),
            )
          ],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 0,
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black38,
                    ),
                  ),
                ),
              ),
              Container(
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
