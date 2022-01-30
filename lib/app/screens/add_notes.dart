import 'package:flash_chat/app/components/input.dart';
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

class AddNotesScreen extends ConsumerWidget {
  final Employee employee;

  const AddNotesScreen({Key? key, required this.employee}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController notescontroller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
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
                        Input(
                            labelText: 'Note',
                            type: TextInputType.text,
                            onChanged: (String nameFile) {},
                            hintText: 'Note',
                            myController: notescontroller),
                        RectangleButton(
                          label: 'Add note',
                          onPressed: () {
                            FirestoreDatabase database = FirestoreDatabase();

                            List<dynamic> notes = employee.notes;

                            notes.add(notescontroller.text);

                            database.updateEmployee(
                                id: employee.uid, data: {'notes': notes});
                            Navigator.pop(context);
                          },
                          icon: Icons.add_circle_outline,
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
