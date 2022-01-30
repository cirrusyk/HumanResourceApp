import 'package:flash_chat/app/components/rectangle_button.dart';
import 'package:flash_chat/app/models/Employee.dart';
import 'package:flash_chat/app/screens/record_attendace_screen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../general_providers.dart';

class AttendanceScreen extends ConsumerWidget {
  final Employee employee;
  static String id = "attendance_screen";

  const AttendanceScreen({
    Key? key,
    required this.employee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: AttendanceData(
        id: employee.uid,
      ),
    );
  }
}

final employeeStreamProvider =
    StreamProvider.autoDispose.family<Employee, String>((ref, friendId) {
  final database = ref.watch(databaseProvider)!;
  return database.employeeStream(id: friendId);
});

class AttendanceData extends ConsumerWidget {
  final String id;

  const AttendanceData({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendAsyncValue = ref.watch(employeeStreamProvider(id));
    return friendAsyncValue.when(
      data: (employee) => SingleChildScrollView(
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RectangleButton(
                    icon: Icons.record_voice_over_rounded,
                    label: 'Record Attendance',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                RecordAttendance(employee: employee)),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.redAccent,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Current Balance',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 0),
                              child: Text(
                                'Attendance',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'images/work.png',
                                  color: Colors.redAccent,
                                  width: 80,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      employee.daysAttended.toString(),
                                      style: TextStyle(
                                        fontSize: 50,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                    Text(
                                      'DAYS',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.monetization_on_outlined,
                          color: Colors.redAccent,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Salary this month',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 0),
                              child: Text(
                                'Salary this month',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'images/money.png',
                                  color: Colors.redAccent,
                                  width: 80,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      employee.monthlySalary.toString(),
                                      style: TextStyle(
                                        fontSize: 50,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                    Text(
                                      'DHS',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      loading: () => Container(),
      error: (_, __) => const Text(
        "error",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
