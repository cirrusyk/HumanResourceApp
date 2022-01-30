import 'package:flash_chat/app/models/Employee.dart';
import 'package:flash_chat/app/screens/attendance_screen.dart';
import 'package:flash_chat/app/screens/documents_screen.dart';
import 'package:flash_chat/app/screens/info_screen.dart';
import 'package:flash_chat/app/screens/notes_screen.dart';
import 'package:flash_chat/app/screens/time_off_screen.dart';
import 'package:flutter/material.dart';

class EmployeeScreen extends StatelessWidget {
  final Employee employee;

  static String id = "employee_screen";
  EmployeeScreen({required this.employee});
  @override
  Widget build(BuildContext context) {
    int duration = 0;
    String reason = '';
    MaterialPageRoute(
      builder: (context) => TimeOffScreen(
        employee: employee,
        duration: duration,
        reason: reason,
      ),
    );
    MaterialPageRoute(
      builder: (context) => AttendanceScreen(employee: employee),
    );
    // MaterialPageRoute(
    //   builder: (context) => DocumentsScreen(employee: employee),
    // );
    MaterialPageRoute(
      builder: (context) => NotesScreen(employee: employee),
    );

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[],
          title: Text(employee.firstname + " " + employee.lastname),
          backgroundColor: Colors.redAccent,
          bottom: TabBar(
            isScrollable: true,
            tabs: <Widget>[
              Tab(
                text: "Info",
              ),
              Tab(
                text: "Time off",
              ),
              Tab(
                text: "Attendance",
              ),
              // Tab(
              //   text: "Documents",
              // ),
              Tab(
                text: "Notes",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            InfoScreen(employee: employee),
            TimeOffScreen(
              employee: employee,
              duration: duration,
              reason: reason,
            ),
            AttendanceScreen(employee: employee),
            // DocumentsScreen(employee: employee),
            NotesScreen(employee: employee),
          ],
        ),
      ),
    );
  }
}
