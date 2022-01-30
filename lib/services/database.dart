import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  final String uid;

  DataBaseService({required this.uid});

  //collection reference
  final CollectionReference MyEmployees =
      FirebaseFirestore.instance.collection('employees');

  Future<void> updateEmployeeInfo(
    String firstName,
    String lastName,
    String profession,
    String status,
    String email,
    String phone,
    String birth,
    String address,
    String taxNumber,
    String major,
    double salary,
  ) async {
    return await MyEmployees.doc(uid).set(({
      "uid": uid,
      "firstName": firstName,
      "lastName": lastName,
      "profession": profession,
      "status": status,
      "email": email,
      "phone": phone,
      "birth": birth,
      "address": address,
      "taxNumber": taxNumber,
      "major": major,
      "salary": salary,
    }));
  }

  // add Get employee info here

  // Get employees
  Future getEmployeesList() async {
    List itemList = [];

    try {
      await MyEmployees.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemList.add(element.data());
        });
      });
      return itemList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
