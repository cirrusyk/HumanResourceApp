import 'package:flash_chat/app/components/rectangle_button.dart';
import 'package:flash_chat/app/models/Employee.dart';
import 'package:flash_chat/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../general_providers.dart';

final employeeStreamProvider =
    StreamProvider.autoDispose.family<Employee, String>((ref, friendId) {
  final database = ref.watch(databaseProvider)!;
  return database.employeeStream(id: friendId);
});

final counterProvider = StateProvider((ref) => 0);

class RecordAttendance extends ConsumerWidget {
  final Employee employee;

  const RecordAttendance({Key? key, required this.employee}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late DateTimeRange dateRange =
        DateTimeRange(start: DateTime(2022, 11, 5), end: DateTime(2022, 11, 7));
    final difference = dateRange.duration.inDays;

    Future pickDate(BuildContext context) async {
      final newDateRange = await showDateRangePicker(
          context: context,
          firstDate: DateTime(DateTime.now().year - 5),
          lastDate: DateTime(DateTime.now().year + 5),
          initialDateRange: dateRange,
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: Colors.redAccent, // header background color
                  onPrimary: Colors.white, // header text color
                  onSurface: Colors.redAccent, // body text color
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    primary: Colors.red, // button text color
                  ),
                ),
              ),
              child: child!,
            );
          });

      if (newDateRange == null) return;
      ref.read(counterProvider.state).state = newDateRange.duration.inDays;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Record Attendance'),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Text(
                                'Duration',
                                style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        pickDate(context);
                                      },
                                      child: Container(
                                        child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 0, 0, 5),
                                          child: Consumer(
                                              builder: (context, ref, child) {
                                            final count = ref
                                                .watch(counterProvider.state)
                                                .state;
                                            return Text(
                                              '${count} days',
                                              style: TextStyle(
                                                  fontSize: 23,
                                                  color: Colors.redAccent),
                                            );
                                          }),
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.redAccent,
                                                  width: 1)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        RectangleButton(
                          label: 'Submit',
                          onPressed: () {
                            int duration =
                                ref.read(counterProvider.state).state;
                            print(duration);

                            FirestoreDatabase database = FirestoreDatabase();
                            if (employee.timeOffsick < 0) {
                              employee.daysAttended =
                                  employee.daysAttended + employee.timeOffsick;
                              database.updateEmployee(id: employee.uid, data: {
                                'timeOffsick': 0,
                              });
                            }
                            if (employee.timeOffvacation < 0) {
                              employee.daysAttended = employee.daysAttended +
                                  employee.timeOffvacation;
                              database.updateEmployee(id: employee.uid, data: {
                                'timeOffvacation': 0,
                              });
                            }

                            if (employee.daysAttended + duration >= 31) {
                              employee.monthlySalary = 0.0;
                              employee.daysAttended = 0;
                              database.updateEmployee(id: employee.uid, data: {
                                'daysAttended': 0 + duration,
                                'monthlySalary': duration * employee.wagePerDay,
                              });
                              employee.monthlySalary =
                                  duration * employee.wagePerDay;
                              Navigator.pop(context);
                            } else if (employee.daysAttended < 31) {
                              database.updateEmployee(id: employee.uid, data: {
                                'daysAttended':
                                    employee.daysAttended + duration,
                                'monthlySalary': (employee.wagePerDay *
                                    (employee.daysAttended + duration))
                              });
                              employee.monthlySalary = (employee.wagePerDay *
                                  (employee.daysAttended + duration));
                              Navigator.pop(context);
                            }
                          },
                          icon: Icons.add,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
