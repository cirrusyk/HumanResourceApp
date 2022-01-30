import 'package:flash_chat/services/auth_model.dart';
import 'package:flutter/material.dart';

class SignInGoogleButton extends StatelessWidget {
  const SignInGoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await Authentication().signInWithGoogle();
      },
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadiusDirectional.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const [
              Text(
                'Sign in with Google',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
