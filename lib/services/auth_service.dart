// import 'package:chatapp/helpers/function_helper.dart';
// import 'package:chatapp/models/user_model.dart' as app;
// import 'package:chatapp/routes/app_routes.dart';
// import 'package:chatapp/routes/navigation_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'database_service.dart';
// import 'package:uuid/uuid.dart';
//
// class AuthMethods {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//
//   Future<User?> getCurrentUser() async => auth.currentUser;
//
//   signInWithGoogle() async {
//     final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//     final GoogleSignIn _googleSignIn = GoogleSignIn();
//
//     final GoogleSignInAccount? googleSignInAccount =
//         await _googleSignIn.signIn();
//
//     final GoogleSignInAuthentication googleSignInAuthentication =
//         await googleSignInAccount!.authentication;
//
//     final AuthCredential credential = GoogleAuthProvider.credential(
//         idToken: googleSignInAuthentication.idToken,
//         accessToken: googleSignInAuthentication.accessToken);
//
//     await _firebaseAuth.signInWithCredential(credential);
//
//     Map<String, dynamic>? idMap =
//         FunctionHelper.parseJwt(googleSignInAuthentication.idToken ?? "");
//
//     //app.User _user = await Preferences().getUser;
//
//     // UserInfo profile = await auth.currentUser!.providerData.first;
//     bool exists = await DatabaseMethods.checkIfUserExists(idMap['email']);
//     app.User _user = app.User(
//         uuid: const Uuid().v1(),
//         firstname: idMap['given_name'],
//         lastname: idMap['family_name'],
//         email: idMap['email'],
//         udid: await FunctionHelper().getId() ?? "NO_DEVICE_ID",
//         profilepicture: idMap['picture']);
//
//     //String? token = "";
//
//     // Map<String, dynamic> userInfoMap = {
//     //   "pushtoken": token,
//     //   //TODO kijken naar push notificaties
//     //};
//     if (!exists) {
//       DatabaseMethods().addUserInfoToDB(idMap['email'], _user.toMap());
//     }
//
//     //Preferences().setUser(_user);
//   }
//
//   signInWithEmailAndPassword(String email, String password) async {
//     await auth.signInWithEmailAndPassword(email: email, password: password);
//     Navigation.instance.pushNamed(Routes.home);
//   }
//
//   signUpWithEmailAndPassword(String email, String password) async {
//     await auth.createUserWithEmailAndPassword(email: email, password: password);
//
//     // String firstname = SignupController.to.firstnameC.text;
//     // String lastname = SignupController.to.lastnameC.text;
//     String firstname = "firstname";
//     String lastname = "lastname";
//     app.User user = app.User(
//         uuid: const Uuid().v1(),
//         firstname: firstname,
//         lastname: lastname,
//         email: email,
//         udid: "notimplemented");
//     DatabaseMethods().addUserInfoToDB(email, user.toMap());
// //    Preferences().setUser(user);
//     Navigation.instance.pushNamed(Routes.home);
//   }
//
//   Future signOut() async {
//     //  await Preferences.getUserBox().then((value) => value.deleteAll);
//     await auth.signOut();
//     Navigation.instance.pushReplace(Routes.signin);
//   }
// }
