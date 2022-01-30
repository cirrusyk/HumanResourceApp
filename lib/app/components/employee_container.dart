import 'package:flash_chat/app/models/Employee.dart';
import 'package:flash_chat/app/screens/employee_screen.dart';
import 'package:flutter/material.dart';

class EmployeeContainer extends StatelessWidget {
  final Employee employee;

  EmployeeContainer({required this.employee});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          print('test');
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EmployeeScreen(
                employee: employee,
              ),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 16, 24, 0),
                  child: Text(
                    employee.fullname,
                    style: TextStyle(fontSize: 27),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 0, 20),
                  child: Text(
                    employee.profession,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
