import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/routes/app_routes.dart';
import 'package:flash_chat/routes/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  // For Authentication related functions you need an instance of FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //  This getter will be returning a Stream of User object.
  //  It will be used to check if the user is logged in or not.
  Stream<User?> get authStateChange => _auth.authStateChanges();

  getCurrentUser() async {
    return _auth.currentUser;
  }

  // Now This Class Contains 3 Functions currently
  // 1. signInWithGoogle
  // 2. signOut
  // 3. signInwithEmailAndPassword

  //  All these functions are async because this involves a future.
  //  if async keyword is not used, it will throw an error.
  //  to know more about futures, check out the documentation.
  //  https://dart.dev/codelabs/async-await
  //  Read this to know more about futures.
  //  Trust me it will really clear all your concepts about futures

  //  SigIn the user using Email and Password
  void signInWithEmailAndPassword(String email, String password) async {
//TODO check if textfield is valid
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigation.instance.pushNamed(Routes.home),
              });
    } on FirebaseAuthException catch (error) {
      String errorMessage = "";
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";

          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      print(errorMessage);
    }
  }

  // SignUp the user using Email and Password
  Future<void> signUpWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigation.instance.pushNamed(Routes.home);
    } on FirebaseAuthException catch (e) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                  title: const Text('Error Occured'),
                  content: Text(e.toString()),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: const Text("OK"))
                  ]));
    }
  }

  //  SignIn the user Google
  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      await _auth.signInWithCredential(credential);
      Navigation.instance.pushReplace("all_screen");
      // final GoogleSignInAuthentication googleSignInAuthentication =
      //     await googleUser.authentication;
      // final idToken = googleSignInAuthentication.idToken;
      // Map<String, dynamic>? idMap = parseJwt(idToken!);
      //
      // if (idMap != null) {
      //   app.User user = app.User(
      //     birthday: DateTime.now(),
      //     firstname: idMap["given_name"],
      //     id: _auth.currentUser?.uid ?? "",
      //     lastname: idMap["family_name"],
      //     email: googleUser.email,
      //     displayname: googleUser.displayName ??
      //         "${idMap["firstname"]} + ${idMap["family_name"]}",
      //     phonenumber: idMap["phone_number"],
      //     profilepicture: googleUser.photoUrl,
      //   );
      //   FirestoreDatabase(uid: user.id).addUser(user);
      //   Navigation.instance.pushReplace(Routes.dashboard);
      // }
    } on FirebaseAuthException catch (error) {
      String errorMessage = "";
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";

          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      print(errorMessage);
    }
  }

  //  SignOut the current user
  Future<void> signOut() async {
    await _auth.signOut();
    Navigation.instance.pushReplace(Routes.signin);
  }

  static Map<String, dynamic>? parseJwt(String token) {
    // validate token
    final List<String> parts = token.split('.');
    if (parts.length != 3) {
      return null;
    }
    // retrieve token payload
    final String payload = parts[1];
    final String normalized = base64Url.normalize(payload);
    final String resp = utf8.decode(base64Url.decode(normalized));
    // convert to Map
    final payloadMap = json.decode(resp);
    if (payloadMap is! Map<String, dynamic>) {
      return null;
    }
    return payloadMap;
  }
}
