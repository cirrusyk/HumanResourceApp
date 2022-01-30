import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flash_chat/app/components/input.dart';
import 'package:flash_chat/app/components/rectangle_button.dart';
import 'package:flash_chat/app/models/Employee.dart';
import 'package:flash_chat/services/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart';

import '../../general_providers.dart';

final employeeStreamProvider =
    StreamProvider.autoDispose.family<Employee, String>((ref, friendId) {
  final database = ref.watch(databaseProvider)!;
  return database.employeeStream(id: friendId);
});

class UploadDocumentScreen extends ConsumerWidget {
  final Employee employee;

  const UploadDocumentScreen({Key? key, required this.employee})
      : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UploadTask? task;
    File? file;
    final fileName = file != null ? basename(file.path) : 'No file Selected';
    TextEditingController nameFilecontroller = TextEditingController();
    Future selectFile() async {
      final result = await FilePicker.platform.pickFiles(allowMultiple: false);

      if (result == null) return;
      final path = result.files.single.path!;

      file = File(path);
    }

    Future uploadFile() async {
      if (file == null) return;
      final fileName = basename(file!.path);
      final destination = 'file/$fileName';

      FirebaseApi.uploadFile(destination, file!);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Document'),
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
                            labelText: 'Name of file',
                            type: TextInputType.text,
                            onChanged: (String nameFile) {},
                            hintText: 'Name of file',
                            myController: nameFilecontroller),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            RectangleButton(
                              label: 'Add file',
                              onPressed: () {
                                selectFile();
                              },
                              icon: Icons.add,
                            ),
                            Center(child: Text(fileName)),
                          ],
                        ),
                        RectangleButton(
                          label: 'Upload',
                          onPressed: () {
                            uploadFile();
                          },
                          icon: Icons.upload_rounded,
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
