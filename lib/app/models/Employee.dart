class Employee {
  String firstname;
  String lastname;
  String profession;
  String status;
  String email;
  String phone;
  String birthday;
  String address;
  String uid;
  String taxnumber;
  String major;
  String fullname;
  double wagePerDay;
  double monthlySalary;
  int timeOffvacation;
  int timeOffsick;
  int daysAttended;
  List<dynamic> notes;
  Employee({
    required this.uid,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.birthday,
    required this.profession,
    required this.address,
    required this.status,
    required this.wagePerDay,
    required this.taxnumber,
    required this.major,
    required this.timeOffsick,
    required this.timeOffvacation,
    required this.daysAttended,
    required this.monthlySalary,
    required this.notes,
  }) : fullname = firstname + " " + lastname;

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'phone': phone,
      'birthday': birthday,
      'major': major,
      'taxnumber': taxnumber,
      'status': status,
      'profession': profession,
      'address': address,
      'wagePerDay': wagePerDay,
      'timeOffsick': timeOffsick,
      'timeOffvacation': timeOffvacation,
      'daysAttended': daysAttended,
      'monthlySalary': monthlySalary,
      'notes': notes,
    };
  }

  factory Employee.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      throw StateError('missing data for id: ');
    }

    final uid = data['uid'] as String?;
    if (uid == null) {
      throw StateError('missing uid for uid: $uid');
    }

    final firstname = data['firstname'] as String?;
    if (firstname == null) {
      throw StateError('missing firstname for uuid: $uid');
    }

    final lastname = data['lastname'] as String?;
    if (lastname == null) {
      throw StateError('missing lastname for uuid: $uid');
    }

    final email = data['email'] as String?;
    if (email == null) {
      throw StateError('missing email for uuid: $uid');
    }

    final address = data['address'] as String?;
    if (address == null) {
      throw StateError('missing address for uuid: $uid');
    }

    final phone = data['phone'] as String?;
    if (phone == null) {
      throw StateError('missing phone for uuid: $uid');
    }

    final taxnumber = data['taxnumber'] as String?;
    if (taxnumber == null) {
      throw StateError('missing taxnumber for uuid: $uid');
    }

    final major = data['major'] as String?;
    if (major == null) {
      throw StateError('missing major for uuid: $uid');
    }

    final profession = data['profession'] as String?;
    if (profession == null) {
      throw StateError('missing proffesion for uuid: $uid');
    }
    final status = data['status'] as String?;
    if (status == null) {
      throw StateError('missing status for uuid: $uid');
    }

    final birthday = data["birthday"] as String?;
    if (birthday == null) {
      throw StateError('missing birthday for uuid: $uid');
    }

    var wagePerDay = data['wagePerDay'];
    if (wagePerDay == null)
      wagePerDay = data['wagePerDay'].toString() as double?;

    var monthlySalary = data['monthlySalary'];
    if (monthlySalary == null)
      monthlySalary = data['monthlySalary'].toString() as double?;

    var timeOffsick = data['timeOffsick'];
    if (timeOffsick == null)
      timeOffsick = data['timeOffsick'].toString() as int?;

    var timeOffvacation = data['timeOffvacation'];
    if (timeOffvacation == null)
      timeOffvacation = data['timeOffvacation'].toString() as int?;

    var daysAttended = data['daysAttended'];
    if (daysAttended == null)
      daysAttended = data['daysAttended'].toString() as int?;

    var notes = data['notes'];
    if (notes == null) notes = data['notes'].toString() as List<dynamic>?;

    return Employee(
      uid: uid,
      firstname: firstname,
      lastname: lastname,
      email: email,
      phone: phone,
      profession: profession,
      address: address,
      birthday: birthday,
      status: status,
      wagePerDay: wagePerDay,
      major: major,
      taxnumber: taxnumber,
      timeOffsick: timeOffsick,
      timeOffvacation: timeOffvacation,
      daysAttended: daysAttended,
      monthlySalary: monthlySalary,
      notes: notes,
    );
  }
}
