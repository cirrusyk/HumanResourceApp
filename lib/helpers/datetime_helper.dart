import 'package:intl/intl.dart';
import 'string_helper.dart';

extension DatetimeConvert on DateTime {
  String dateString() {
    return DateFormat('dd-MM-y').format(this);
  }

  String format(String option) => DateFormat(option).format(this);

  get dateId => DateFormat("yyyy-d-M").format(this);

  String dayString(String option) {
    option = option.toLowerCase();
    return ['short', 'long'].contains(option)
        ? DateFormat(option == 'short' ? 'M' : 'MM').format(this)
        : "Wrong option given use 'short' or 'long'";
  }

  String dayNum(String option) {
    option = option.toLowerCase();
    return ['short', 'long'].contains(option)
        ? DateFormat(option == 'short' ? 'd' : 'dd').format(this)
        : "Wrong option given use 'short' or 'long'";
  }

  String toTimeString(String precision) {
    precision = precision.toLowerCase();
    if (precision == 'hours' || precision == 'hour') {
      return DateFormat('HH').format(this);
    } else if (precision == 'minutes' || precision == 'minute') {
      return DateFormat('HH:mm').format(this);
    } else if (precision == 'seconds' || precision == 'second') {
      return DateFormat('HH:mm:ss').format(this);
    } else {
      return DateFormat('HH:mm:ss').format(this);
    }
  }

  String toAppointmentDateString({required String precision}) {
    precision = precision.toLowerCase();
    if (precision == 'year' || precision == 'years') {
      return DateFormat('EEEE d MMMM y HH:mm').format(this);
    } else if (precision == 'month' || precision == 'months') {
      return DateFormat('EEEE d MMMM HH:mm').format(this);
    } else if (precision == 'day' || precision == 'days') {
      return DateFormat('EEEE HH:mm').format(this);
    } else {
      return "Wrong input given use 'year', 'month' or 'day'";
    }
  }

  String toInput(String orginalInput) {
    orginalInput = orginalInput.trim();
    String input = orginalInput.toLowerCase();

    while (input.contains('  ')) {
      input = input.replaceAll('  ', ' ');
    }

    var inputs = input.split(' ');
    var originalInputs = orginalInput.split(' ');

    var map = {
      'minutes': 'mm',
      'minutesshort': 'm',
      'hours': 'HH',
      'hoursshort': 'H',
      'daynum': 'dd',
      'daynumshort': 'd',
      'daystring': 'EEEE',
      'daystringshort': 'E',
      'monthnum': 'M',
      'year': 'yyyy',
      'yearshort': 'yy',
      'january': 'MMMM',
      'february': 'MMMM',
      'march': 'MMMM',
      'april': 'MMMM',
      'may': 'MMMM',
      'june': 'MMMM',
      'july': 'MMMM',
      'august': 'MMMM',
      'october': 'MMMM',
      'november': 'MMMM',
      'december': 'MMMM',
      'jan': 'MMM',
      'feb': 'MMM',
      'mar': 'MMM',
      'apr': 'MMM',
      'jun': 'MMM',
      'jul': 'MMM',
      'aug': 'MMM',
      'oct': 'MMM',
      'nov': 'MMM',
      'dec': 'MMM',
      'monday': 'EEEE',
      'tuesday': 'EEEE',
      'wednesday': 'EEEE',
      'thursday': 'EEEE',
      'friday': 'EEEE',
      'saturday': 'EEEE',
      'sunday': 'EEEE',
      'mon': 'EE',
      'tue': 'EE',
      'wed': 'EE',
      'thu': 'EE',
      'fri': 'EE',
      'sat': 'EE',
      'sun': 'EE',
    };

    for (var i = 0; i < inputs.length; i++) {
      String char = inputs[i].indexOf('-') > inputs[i].indexOf('/') ? '-' : '/';
      //check for possible input {0}9:02:01
      if (inputs[i].contains(':') && inputs.length <= 8) {
        var times = inputs[i].split(':');
        if (times[0].isNummeric && times[1].isNummeric) {
          if (times.length >= 2) {
            inputs[i] = '${'H' * times[0].length}:${'m' * times[1].length}';

            inputs[i] += times.length == 3 && times[2].isNummeric
                ? ':${'s' * times[2].length}'
                : '';
          }
        }
        var formatstring =
            inputs.reduce((value, element) => value + ' ' + element);
        var formattedDate = DateFormat(formatstring).format(this);
        return formattedDate;
      }
      //check for possible input {0}2-{0}1-{20}20
      //check for possible input {0}2/{0}1/{20}20
      else if (inputs[i].contains(char)) {
        var temp = inputs[i].split(char);

        if (temp.length >= 2) {
          if (temp[0].isAlphabetOnly && temp[1].isAlphabetOnly) {
            inputs[i] = map[temp[0]]! + char + map[temp[1]]!;
            inputs[i] +=
                temp.length == 3 && temp[2].isAlphabetOnly ? map[temp[2]]! : '';
          } else {
            bool shortday =
                temp[0].length == 2 && int.parse(temp[0]) < 10 && day < 10;
            bool shortmonth =
                temp[1].length == 2 && int.parse(temp[1]) < 10 && month < 10;
            inputs[i] = (shortday ? '0' : '') +
                map['daynumshort']! +
                char +
                (shortmonth ? '0' : '') +
                map['monthnum']!;
            inputs[i] += temp.length == 3 && temp[2].isNummeric
                ? char + 'y' * temp[2].length
                : '';
          }
        }
      } else if (inputs[i].length == 4 && inputs[i].isNummeric) {
        inputs[i] = 'yyyy';
      } else {
        inputs[i] = map[inputs[i]] ?? inputs[i];
      }
    }

    var formatstring = inputs.reduce((value, element) => value + ' ' + element);
    var formattedDate = DateFormat(formatstring).format(this);

    String newString = "";

    for (int i = 0; i < formattedDate.split(" ").length; i++) {
      var time = formattedDate.split(" ")[i];
      if (!time.isNummeric) {
        String toAdd = time.toLowerCase().capPattern(originalInputs[i]);
        newString += toAdd + " ";
      } else {
        newString += time;
      }
    }
    return newString;
  }

  bool operator >(DateTime other) {
    return isAfter(other);
  }

  bool operator <(DateTime other) {
    return isBefore(other);
  }

  bool operator <=(DateTime other) {
    return isBefore(other) || isAtSameMomentAs(other);
  }

  bool operator >=(DateTime other) {
    return isAfter(other) || isAtSameMomentAs(other);
  }

  DateTime copyWith(
      {int? year,
      int? month,
      int? day,
      int? hour,
      int? minute,
      int? millisecond,
      int? second,
      int? microsecond}) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  // datetime.minuteSince(9:00)
  double minuteSince(int hour, int minute) {
    DateTime blankDate = copyWith(hour: hour, minute: minute);
    return -blankDate.difference(this).inMinutes.toDouble();
  }
}
