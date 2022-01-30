import 'package:flash_chat/routes/app_routes.dart';
import 'package:flash_chat/routes/navigation_service.dart';
import 'package:flash_chat/theme/theme_constants.dart';
import 'package:flash_chat/widgets/primary_action_button_widget.dart';
import 'package:flutter/material.dart';

class QuickActionSign extends StatelessWidget {
  final void Function() signAction;
  final String title;
  const QuickActionSign(
      {Key? key, required this.signAction, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isSignin = title.toLowerCase() != "sign in";
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: PrimaryActionButton(
            action: signAction,
            text: _isSignin ? "Sign Up" : "Sign In",
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => _isSignin
                ? Navigation.instance.pushReplace(Routes.signin)
                : Navigation.instance.pushNamed(Routes.signup),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _isSignin ? "I'm already a user." : "I'm a new user.",
                  style: Theme.of(context).textTheme.subtitle2!,
                ),
                const SizedBox(width: 8.0),
                Text(
                  _isSignin ? "Sign In" : "Sign Up",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: Themes.primaryColor),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
