import 'package:flash_chat/app/components/employee_container.dart';
import 'package:flash_chat/app/components/list-builder.dart';
import 'package:flash_chat/app/components/rectangle_button.dart';
import 'package:flash_chat/app/models/Employee.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../general_providers.dart';
import 'add_notes.dart';

class NotesScreen extends ConsumerWidget {
  final Employee employee;
  static String id = "notes_screen";

  const NotesScreen({
    Key? key,
    required this.employee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: NotesData(
        id: employee.uid,
      ),
    );
  }
}

final employeeStreamProvider =
    StreamProvider.autoDispose.family<Employee, String>((ref, employeeID) {
  final database = ref.watch(databaseProvider)!;
  return database.employeeStream(id: employeeID);
});
final listProvider = StateProvider((ref) => []);

class NotesData extends ConsumerWidget {
  final String id;

  const NotesData({
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
                children: [
                  RectangleButton(
                    icon: Icons.note_sharp,
                    label: 'Add notes',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                AddNotesScreen(employee: employee)),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.speaker_notes,
                          color: Colors.redAccent,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Notes',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      var value = ref.watch(listProvider.state).state;

                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: employee.notes.length,
                          itemBuilder: (context, index) => NoteWidget(
                                note: employee.notes[index],
                                onTap: () {
                                  ref.refresh(listProvider.state).state =
                                      employee.notes;
                                  employee.notes.remove(ref
                                      .read(listProvider.state)
                                      .state[index]);
                                  ref.read(listProvider.state).state =
                                      employee.notes;
                                  ref.refresh(listProvider.state).state =
                                      employee.notes;
                                },
                              ));
                    },
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

class NoteWidget extends StatelessWidget {
  final String note;
  final Function() onTap;
  const NoteWidget({
    Key? key,
    required this.note,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 10, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'images/note.png',
                width: 50,
                color: Colors.redAccent,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                note,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: onTap,
            child: Icon(
              Icons.highlight_remove,
              color: Colors.redAccent,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
