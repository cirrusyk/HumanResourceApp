import 'package:flash_chat/app/components/rectangle_button.dart';
import 'package:flash_chat/app/models/Employee.dart';
import 'package:flash_chat/app/screens/upload_documents.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../general_providers.dart';

class DocumentsScreen extends ConsumerWidget {
  final Employee employee;
  static String id = "documents_screen";
  const DocumentsScreen({
    Key? key,
    required this.employee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: DocumentsData(
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

class DocumentsData extends ConsumerWidget {
  final String id;

  const DocumentsData({
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
                    icon: Icons.drive_file_move,
                    label: 'Upload Documents',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                UploadDocumentScreen(employee: employee)),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.document_scanner_outlined,
                          color: Colors.redAccent,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Added Documents',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 10, 20, 10),
                    child: Row(
                      children: [
                        Image.asset(
                          'images/folder.jpg',
                          width: 50,
                          color: Colors.redAccent,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Degree',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 10, 20, 10),
                    child: Row(
                      children: [
                        Image.asset(
                          'images/folder.jpg',
                          width: 50,
                          color: Colors.redAccent,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'CV',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 10, 20, 10),
                    child: Row(
                      children: [
                        Image.asset(
                          'images/folder.jpg',
                          width: 50,
                          color: Colors.redAccent,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Diploma',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
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
