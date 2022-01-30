import 'package:flash_chat/app/components/input.dart';
import 'package:flash_chat/app/components/rectangle_button.dart';
import 'package:flash_chat/app/models/Employee.dart';
import 'package:flash_chat/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddEmployeeScreen extends StatefulWidget {
  static String id = "add_employee_screen";

  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController statusController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController wagePerDayController = TextEditingController();
  TextEditingController majorController = TextEditingController();
  TextEditingController taxnumberController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController vacationController = TextEditingController();
  TextEditingController sicknessController = TextEditingController();
  TextEditingController daysAttendedController = TextEditingController();

  var uuid = Uuid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
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
                          myController: firstnameController,
                          labelText: 'First name',
                          onChanged: (String firstname) {},
                          type: TextInputType.name,
                          hintText: 'First name',
                        ),
                        Input(
                          myController: lastnameController,
                          labelText: 'Last name',
                          onChanged: (String lastname) {},
                          type: TextInputType.name,
                          hintText: 'Last name',
                        ),
                        Input(
                          myController: professionController,
                          labelText: 'Profession',
                          onChanged: (String profession) {},
                          type: TextInputType.name,
                          hintText: 'Profession',
                        ),
                        Input(
                          myController: wagePerDayController,
                          labelText: 'Wage Per Day',
                          type: TextInputType.number,
                          onChanged: (String salary) {},
                          hintText: 'Wage Per Day',
                        ),
                        Input(
                          myController: vacationController,
                          labelText: 'Days off Vacation',
                          type: TextInputType.number,
                          onChanged: (String salary) {},
                          hintText: 'Days off Vacation',
                        ),
                        Input(
                          myController: sicknessController,
                          labelText: 'Days off Sickness',
                          type: TextInputType.number,
                          onChanged: (String salary) {},
                          hintText: 'Days off Sickness',
                        ),
                        Input(
                          myController: statusController,
                          labelText: 'Status',
                          onChanged: (String status) {},
                          type: TextInputType.name,
                          hintText: 'Status',
                        ),
                        Input(
                          myController: emailController,
                          labelText: 'Email',
                          type: TextInputType.emailAddress,
                          onChanged: (String email) {},
                          hintText: 'Email',
                        ),
                        Input(
                          myController: phoneController,
                          labelText: 'Phone number',
                          type: TextInputType.phone,
                          onChanged: (String phone) {},
                          hintText: 'Phone number',
                        ),
                        Input(
                          myController: birthdayController,
                          labelText: 'Date of birth',
                          type: TextInputType.datetime,
                          hintText: "dd/mm/yy",
                          onChanged: (String birth) {},
                        ),
                        Input(
                          myController: addressController,
                          labelText: 'Address',
                          type: TextInputType.streetAddress,
                          onChanged: (String address) {},
                          hintText: 'Address',
                        ),
                        Input(
                          myController: taxnumberController,
                          labelText: 'Tax file number',
                          type: TextInputType.number,
                          onChanged: (String taxnumber) {},
                          hintText: 'Tax number',
                        ),
                        Input(
                          myController: majorController,
                          labelText: 'Major',
                          onChanged: (String major) {},
                          type: TextInputType.name,
                          hintText: 'Major',
                        ),
                        Input(
                          myController: daysAttendedController,
                          labelText: 'Days Attended this month',
                          onChanged: (String major) {},
                          type: TextInputType.number,
                          hintText: 'Days Attended this month',
                        ),
                        RectangleButton(
                          label: 'Add Employee',
                          onPressed: () {
                            Employee employee = Employee(
                              uid: uuid.v4(),
                              firstname: firstnameController.text,
                              lastname: lastnameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                              birthday: birthdayController.text,
                              profession: professionController.text,
                              address: addressController.text,
                              status: statusController.text,
                              wagePerDay:
                                  double.parse(wagePerDayController.text),
                              taxnumber: taxnumberController.text,
                              major: majorController.text,
                              timeOffvacation:
                                  int.parse(vacationController.text),
                              timeOffsick: int.parse(sicknessController.text),
                              daysAttended:
                                  int.parse(daysAttendedController.text),
                              monthlySalary:
                                  double.parse(wagePerDayController.text) *
                                      int.parse(daysAttendedController.text),
                              notes: [],
                            );
                            FirestoreDatabase firestoreDatabase =
                                FirestoreDatabase();
                            firestoreDatabase.addEmployee(employee);
                            Navigator.pop(context);
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
