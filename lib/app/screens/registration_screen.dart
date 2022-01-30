import 'package:flash_chat/app/components/rounded_button.dart';
import 'package:flash_chat/app/screens/all_employees_screen.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/services/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = "registration_screen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    setState(() {
                      showSpinner = true;
                    });
                    Authentication auth = new Authentication();
                    auth.signUpWithEmailAndPassword(email, password, context);
                    Alert(
                      context: context,
                      type: AlertType.success,
                      title: "Registration successful",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "OK",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          width: 120,
                          color: Colors.redAccent,
                        )
                      ],
                    ).show();
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                    setState(() {
                      showSpinner = false;
                    });
                    Alert(
                      context: context,
                      type: AlertType.error,
                      title: "Registration Failed",
                      desc: "Try again",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "OK",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          width: 120,
                          color: Colors.redAccent,
                        )
                      ],
                    ).show();
                  }
                },
                title: 'Register',
                colour: Colors.redAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
