import 'package:flash_chat/app/components/employee_container.dart';
import 'package:flash_chat/app/models/Employee.dart';
import 'package:flash_chat/app/screens/add_employee.dart';
import 'package:flash_chat/common_widgets/list_items_builder.dart';
import 'package:flash_chat/general_providers.dart';
import 'package:flash_chat/services/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final employeesStreamProvider =
    StreamProvider.autoDispose<List<Employee>>((ref) {
  final database = ref.watch(databaseProvider)!;
  return database.employeesStream();
});

class AllScreen extends ConsumerWidget {
  const AllScreen({Key? key}) : super(key: key);
  static String id = "all_screen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        floatingActionButton: Container(
          height: 75.0,
          width: 80.0,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AddEmployeeScreen.id);
              },
              backgroundColor: Colors.redAccent,
              child: Icon(
                Icons.add,
                size: 25,
              ),
            ),
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Authentication auth = Authentication();
                auth.signOut();
              },
              child: Text('Logout'),
              style: TextButton.styleFrom(
                primary: Colors.white,
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
          title: Text('All Employees'),
          backgroundColor: Colors.redAccent,
        ),
        body: employees(context, ref));
  }

  Widget employees(BuildContext context, WidgetRef ref) {
    final chatAsyncValue = ref.watch(employeesStreamProvider);
    print(chatAsyncValue.value);
    return ListItemsBuilder<Employee>(
      data: chatAsyncValue,
      seperated: false,
      itemBuilder: (context, employee) => EmployeeContainer(
        employee: employee,
      ),
    );
  }
}

//
//
