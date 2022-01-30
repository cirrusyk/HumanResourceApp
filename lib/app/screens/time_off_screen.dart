import 'package:flash_chat/app/components/rectangle_button.dart';
import 'package:flash_chat/app/models/Employee.dart';
import 'package:flash_chat/app/screens/record_timeoff.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../general_providers.dart';

class TimeOffScreen extends ConsumerWidget {
  final Employee employee;
  final int duration;
  final String reason;
  static String id = "timeoff_screen";
  const TimeOffScreen(
      {Key? key,
      required this.employee,
      required this.duration,
      required this.reason})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: TimeOffData(
        id: employee.uid,
        reason: reason,
        duration: duration,
      ),
    );
  }
}

final employeeStreamProvider =
    StreamProvider.autoDispose.family<Employee, String>((ref, friendId) {
  final database = ref.watch(databaseProvider)!;
  return database.employeeStream(id: friendId);
});

class TimeOffData extends ConsumerWidget {
  final String id;
  final String reason;
  final int duration;
  const TimeOffData(
      {Key? key,
      required this.id,
      required this.reason,
      required this.duration})
      : super(key: key);

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
                children: [
                  RectangleButton(
                    icon: Icons.timer,
                    label: 'Record time off',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RecordTimeOffScreen(
                            employee: employee,
                          ),
                        ),
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
                          'Current Balances',
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
                                'Vacation',
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
                                  'images/vacation.png',
                                  color: Colors.redAccent,
                                  width: 80,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      employee.timeOffvacation.toString(),
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
                      SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 0),
                              child: Text(
                                'Sick',
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
                                  'images/sick.png',
                                  color: Colors.redAccent,
                                  width: 70,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      employee.timeOffsick.toString(),
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
