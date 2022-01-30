import 'package:flutter/material.dart';

class Navigation {
  late GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  static Navigation instance = Navigation();

  Future<dynamic> pushReplace(String _rn) {
    return navigationKey.currentState!.pushReplacementNamed(_rn);
  }

  Future<dynamic> pushNamed(String _rn) {
    return navigationKey.currentState!.pushNamed(_rn);
  }

  // Future<dynamic> navigateToRoute(MaterialPageRoute _rn) {
  //   return navigationKey.currentState!.push(_rn);
  // }

  void goback() => navigationKey.currentState!.pop();
}
