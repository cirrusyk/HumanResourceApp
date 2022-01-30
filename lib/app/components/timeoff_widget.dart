import 'package:flutter/material.dart';

class TimeOff extends StatelessWidget {
  final String urlImage;
  final String dates;
  final String time;
  final String reason;
  TimeOff(
      {required this.urlImage,
      required this.dates,
      required this.time,
      required this.reason});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: Row(
        children: [
          Image.asset(
            // ,
            urlImage,
            color: Colors.redAccent,
            width: 55,
          ),
          SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dates,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                time + ' day of ' + reason,
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
