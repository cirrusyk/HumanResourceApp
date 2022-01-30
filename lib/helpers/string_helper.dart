extension StringHelper on String {
  bool checkRepeatingChar() {
    List<String> list = [];
    for (int rune in toLowerCase().runes) {
      String character = String.fromCharCode(rune);
      if (contains('$character' '$character' '$character')) return true;
      if (contains('$character' '$character') && !list.contains(character)) {
        list.add(character);
        if (list.length == 3) return true;
      }
    }
    return false;
  }

  String replaceCharAt(int index, String newChar) =>
      substring(0, index) + newChar + substring(index + 1);

  bool get isNummeric => int.tryParse(this) != null;

  bool get isEmail => RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
      .hasMatch(this);

  bool get isAlphabetOnly => RegExp(r'^[a-zA-Z]+$').hasMatch(this);

  String capPattern(String stringPattern) {
    String newString = "";

    int max = length > stringPattern.length ? length : stringPattern.length;
    int min = length < stringPattern.length ? length : stringPattern.length;
    for (int i = 0; i < max; i++) {
      if (isNummeric || stringPattern.isNummeric) {
        newString += this[i];
      } else {
        if (i < min) {
          String charToAdd = "";
          if (stringPattern.codeUnitAt(i) >= 65 &&
              stringPattern.codeUnitAt(i) <= 90) {
            charToAdd = String.fromCharCode(codeUnitAt(i) - 32);
          } else {
            charToAdd = this[i];
          }
          newString += charToAdd;
        } else {
          newString += this[i];
        }
      }
    }

    return newString;
  }
}
