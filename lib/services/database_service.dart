import 'package:flash_chat/app/models/Employee.dart';

import 'firestore_path.dart';
import 'firestore_service.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase {
  FirestoreDatabase({this.uid = ""});

  // UID of user
  final String uid;
  final _service = FirestoreService.instance;
  late String attribute;
  late String value;

  Future<void> addEmployee(Employee employee) => _service.setData(
        path: FirestorePath.employee(employee.uid),
        data: employee.toMap(),
      );

  Future<void> updateEmployee(
          {required String id, required Map<String, dynamic> data}) =>
      _service.updateData(
        path: FirestorePath.employee(id),
        data: data,
      );

  Stream<Employee> employeeStream({required String id}) =>
      _service.documentStream(
        path: FirestorePath.employee(id),
        builder: (data, documentId) => Employee.fromMap(data!),
      );

  Stream<List<Employee>> employeesStream() => _service.collectionStream(
        path: FirestorePath.employees(),
        builder: (data, documentId) => Employee.fromMap(data!),
      );

// Stream<Group> groupStream({required String friendId}) =>
//     _service.documentStream(
//       path: FirestorePath.group(uid, friendId),
//       builder: (data, documentId) => Group.fromMap(data, documentId),
//     );
//
// Stream<List<Group>> groupsStream() => _service.collectionStream(
//       path: FirestorePath.group(uid),
//       builder: (data, documentId) => Group.fromMap(data, documentId),
//     );

//
//   Future<void> setEntry(Entry entry) => _service.setData(
//         path: FirestorePath.entry(uid, entry.id),
//         data: entry.toMap(),
//       );

  Future<void> deleteEmployees() =>
      _service.deleteData(path: FirestorePath.employees());

  Future<void> deleteEmployee(String id) =>
      _service.deleteData(path: FirestorePath.employee(id));
//
// Stream<List<Entry>> entriesStream({Event? event}) =>
//     _service.collectionStream<Entry>(
//       path: FirestorePath.entries(uid),
//       queryBuilder: event != null
//           ? (query) => query.where('eventId', isEqualTo: event.id)
//           : null,
//       builder: (data, documentID) => Entry.fromMap(data, documentID),
//       sort: (lhs, rhs) => rhs.start.compareTo(lhs.start),
//     );
}
