//https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a?page=1&tab=votes#tab-top

import 'package:flash_chat/helpers/int_helper.dart';
import 'package:flash_chat/helpers/string_helper.dart';
import 'package:flash_chat/helpers/list_helper.dart';

class CustomRegExp {
  CustomRegExp({
    minlenght = 1,
    mincap = 1,
    minletter = 1,
    minlower = 1,
    minnum = 1,
    minspecial = 1,
    maxcap = 30,
    maxletter = 30,
    maxlower = 30,
    maxnum = 30,
    maxspecial = 30,
    maxlenght = 30,
  })  : _minlength = minlenght,
        _mincap = mincap,
        _minlower = minlower,
        _minnum = minnum,
        _minspecial = minspecial,
        _maxcap = maxcap,
        _maxlower = maxlower,
        _maxnum = maxnum,
        _maxspecial = maxspecial,
        _maxlength = maxlenght;
  final int _minlength;
  final int _mincap;
  final int _minlower;
  final int _minnum;
  final int _minspecial;
  final int _maxcap;
  final int _maxlower;
  final int _maxnum;
  final int _maxspecial;
  final int _maxlength;

  bool match(String input) {
    String lowercase = r'^(?=.*[a-z]' '{$_minlower,$_maxlower})';
    String uppercase = r'(?=.*[A-Z]' '{$_mincap,$_maxcap})';
    String special = r'(?=.*[@$!%*?&]' '{$_minspecial,$_maxspecial})';
    String regexp = lowercase + uppercase + special;
    return RegExp(regexp).hasMatch(input) &&
        input.length >= _minlength &&
        input.length < _maxlength;
  }

  bool password(String input) => RegExp(
          r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,30}$")
      .hasMatch(input);

  //
  // int strength(String input) {
  //   String lowercase = r'^(?=.*[a-z]' '{$_minlower,$_maxlower})';
  //   String uppercase = r'(?=.*[A-Z]' '{$_mincap,$_maxcap})';
  //   String special = r'(?=.*[@$!%*?&]' '{$_minspecial,$_maxspecial})';
  //   String number = r'(?=.*[@$!%*?&]' '{$_minnum,$_maxnum})';
  //   bool metlowercase = RegExp(lowercase).hasMatch(input);
  //   bool metuppercase = RegExp(uppercase).hasMatch(input);
  //   bool metspecial = RegExp(special).hasMatch(input);
  //   bool metnum = RegExp(number).hasMatch(input);
  //   bool metlength = input.length >= _minlength && input.length < _maxlength;
  //   int result =
  //       [metlength, metlowercase, metspecial, metuppercase, metnum].count(true);
  //   return metlength
  //       ? result
  //       : input.length >= 6
  //           ? 2
  //           : input.isNotEmpty
  //               ? 1
  //               : input.isEmpty
  //                   ? 0
  //                   : 2;
  // }

  int strengthpassword(String input) {
    String lowercase = r'^(?=.*[a-z]' '{$_minlower,$_maxlower})';
    String uppercase = r'(?=.*[A-Z]' '{$_mincap,$_maxcap})';
    String special = r'(?=.*[@$!%*?&]' '{$_minspecial,$_maxspecial})';
    String number = r'[0-9]' '{$_minnum,$_maxnum}';
    int lenght = input.length;
    bool metlowercase = RegExp(lowercase).hasMatch(input);
    bool metuppercase = RegExp(uppercase).hasMatch(input);
    bool metspecial = RegExp(special).hasMatch(input);
    bool metnum = RegExp(number).hasMatch(input);
    bool metlength = lenght.between(8, _maxlength);
    int result =
        [metlength, metlowercase, metspecial, metuppercase, metnum].count(true);
    if (input.isEmpty || lenght > 30) return 0;
    if (lenght < 6) return 1;
    if (lenght.between(6, 7) || input.checkRepeatingChar()) return 2;
    return result.highest(2);
  }
}
