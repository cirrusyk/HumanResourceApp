import 'package:flash_chat/app/components/info.dart';
import 'package:flash_chat/app/components/rectangle_button.dart';
import 'package:flash_chat/app/models/Employee.dart';
import 'package:flash_chat/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../general_providers.dart';

class InfoScreen extends ConsumerWidget {
  final Employee employee;
  static final id = "info_screen";

  const InfoScreen({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: InfoScreenData(id: employee.uid),
    );
  }
}

final employeeStreamProvider =
    StreamProvider.autoDispose.family<Employee, String>((ref, employeeId) {
  final database = ref.watch(databaseProvider)!;
  return database.employeeStream(id: employeeId);
});

class InfoScreenData extends ConsumerWidget {
  final String id;

  const InfoScreenData({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employeeAsyncValue = ref.watch(employeeStreamProvider(id));
    TextEditingController controller = TextEditingController();
    return employeeAsyncValue.when(
      data: (employee) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // FloatingActionButton(onPressed: () {
          //   getEmployee();
          // }),
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(25, 15, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Info(
                    myController: controller,
                    label: "First Name",
                    value: employee.firstname,
                    onPressed: () {
                      FirestoreDatabase database = FirestoreDatabase();
                      database.updateEmployee(id: employee.uid, data: {
                        'firstname': controller.text,
                      });
                      Navigator.pop(context);
                    },
                  ),
                  Info(
                    myController: controller,
                    label: "Last Name",
                    value: employee.lastname,
                    onPressed: () {
                      FirestoreDatabase database = FirestoreDatabase();
                      database.updateEmployee(id: employee.uid, data: {
                        'lastname': controller.text,
                      });
                      Navigator.pop(context);
                    },
                  ),
                  Info(
                    myController: controller,
                    label: "Profession",
                    value: employee.profession,
                    onPressed: () {
                      FirestoreDatabase database = FirestoreDatabase();
                      database.updateEmployee(id: employee.uid, data: {
                        'profession': controller.text,
                      });
                      Navigator.pop(context);
                    },
                  ),
                  Info(
                    myController: controller,
                    label: "Daily wage",
                    value: employee.wagePerDay.toString(),
                    onPressed: () {
                      FirestoreDatabase database = FirestoreDatabase();
                      database.updateEmployee(id: employee.uid, data: {
                        'wagePerDay': double.parse(controller.text),
                      });
                      Navigator.pop(context);
                    },
                  ),
                  Info(
                    myController: controller,
                    label: "Days Attended this month",
                    value: employee.daysAttended.toString(),
                    onPressed: () {
                      FirestoreDatabase database = FirestoreDatabase();
                      database.updateEmployee(id: employee.uid, data: {
                        'daysAttended': int.parse(controller.text),
                      });
                      Navigator.pop(context);
                    },
                  ),
                  Info(
                    myController: controller,
                    label: "Vacation days",
                    value: employee.timeOffvacation.toString(),
                    onPressed: () {
                      FirestoreDatabase database = FirestoreDatabase();
                      database.updateEmployee(id: employee.uid, data: {
                        'timeOffvacation': int.parse(controller.text),
                      });
                      Navigator.pop(context);
                    },
                  ),
                  Info(
                    myController: controller,
                    label: "Sick days",
                    value: employee.timeOffsick.toString(),
                    onPressed: () {
                      FirestoreDatabase database = FirestoreDatabase();
                      database.updateEmployee(id: employee.uid, data: {
                        'timeOffsick': int.parse(controller.text),
                      });
                      Navigator.pop(context);
                    },
                  ),
                  Info(
                    myController: controller,
                    label: "Status",
                    value: employee.status,
                    onPressed: () {
                      FirestoreDatabase database = FirestoreDatabase();
                      database.updateEmployee(id: employee.uid, data: {
                        'status': controller.text,
                      });
                      Navigator.pop(context);
                    },
                  ),
                  Info(
                    myController: controller,
                    label: "Email",
                    value: employee.email,
                    onPressed: () {
                      FirestoreDatabase database = FirestoreDatabase();
                      database.updateEmployee(id: employee.uid, data: {
                        'email': controller.text,
                      });
                      Navigator.pop(context);
                    },
                  ),
                  Info(
                    myController: controller,
                    label: "Phone Number",
                    value: employee.phone,
                    onPressed: () {
                      FirestoreDatabase database = FirestoreDatabase();
                      database.updateEmployee(id: employee.uid, data: {
                        'phone': controller.text,
                      });
                      Navigator.pop(context);
                    },
                  ),
                  Info(
                    myController: controller,
                    label: "Date of birth",
                    value: employee.birthday.toString(),
                    onPressed: () {
                      FirestoreDatabase database = FirestoreDatabase();
                      database.updateEmployee(id: employee.uid, data: {
                        'birthday': controller.text,
                      });
                      Navigator.pop(context);
                    },
                  ),
                  Info(
                    myController: controller,
                    label: "Address",
                    value: employee.address,
                    onPressed: () {
                      FirestoreDatabase database = FirestoreDatabase();
                      database.updateEmployee(id: employee.uid, data: {
                        'address': controller.text,
                      });
                      Navigator.pop(context);
                    },
                  ),
                  Info(
                    myController: controller,
                    label: "Tax file number",
                    value: employee.taxnumber,
                    onPressed: () {
                      FirestoreDatabase database = FirestoreDatabase();
                      database.updateEmployee(id: employee.uid, data: {
                        'taxnumber': controller.text,
                      });
                      Navigator.pop(context);
                    },
                  ),
                  Info(
                    myController: controller,
                    label: "Major",
                    value: employee.major,
                    onPressed: () {
                      FirestoreDatabase database = FirestoreDatabase();
                      database.updateEmployee(id: employee.uid, data: {
                        'major': controller.text,
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
          RectangleButton(
            label: 'Delete Employee',
            onPressed: () {
              FirestoreDatabase database = FirestoreDatabase();
              database.deleteEmployee(employee.uid);
              Navigator.pop(context);
            },
            icon: Icons.delete,
          ),
        ],
      ),
      loading: () => Container(),
      error: (_, __) => const Text(
        "error",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
