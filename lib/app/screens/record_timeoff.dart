import 'package:flash_chat/app/components/rectangle_button.dart';
import 'package:flash_chat/app/models/Employee.dart';
import 'package:flash_chat/app/screens/time_off_screen.dart';
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
final stringProvider = StateProvider((ref) => 'Sickness');

class RecordTimeOffScreen extends ConsumerWidget {
  final Employee employee;

  const RecordTimeOffScreen({Key? key, required this.employee})
      : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late DateTimeRange dateRange =
        DateTimeRange(start: DateTime(2022, 11, 5), end: DateTime(2022, 11, 7));
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
        title: Text('Record Time-off'),
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
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 30, 15, 5),
                          child: Text(
                            'Reason',
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 5, 15, 15),
                          child: Consumer(
                            builder: (context, ref, child) {
                              final value =
                                  ref.watch(stringProvider.state).state;
                              return DropdownButton<String>(
                                value: value,
                                icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                style: const TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 22,
                                ),
                                underline: Container(
                                  height: 1,
                                  color: Colors.redAccent,
                                ),
                                onChanged: (String? newValue) {
                                  ref.read(stringProvider.state).state =
                                      newValue!;
                                },
                                items: <String>[
                                  'Sickness',
                                  'Vacation'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              );
                            },
                          ),
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
                            String reason =
                                ref.read(stringProvider.state).state;
                            print(reason);
                            FirestoreDatabase database = FirestoreDatabase();
                            database.updateEmployee(id: employee.uid, data: {
                              if (reason == 'Vacation')
                                'timeOffvacation':
                                    employee.timeOffvacation - duration
                              else if (reason == 'Sickness')
                                'timeOffsick': employee.timeOffsick - duration
                            });
                            Navigator.pop(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TimeOffScreen(
                                  employee: employee,
                                  duration: duration,
                                  reason: reason,
                                ),
                              ),
                            );
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
