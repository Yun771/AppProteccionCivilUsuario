import 'package:intl/intl.dart';

bool isNumeric(String s) {
  if (s.isEmpty) return false;

  final n = num.tryParse(s);

  return (n == null) ? false : true;
}

bool isaPhoneNumber(String value) {
  String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  RegExp regExp = new RegExp(patttern);

  if (!regExp.hasMatch(value)) {
    return true;
  }
}

String getDate() {
  var now = new DateTime.now();
  var formatter = new DateFormat.yMd().add_jm();
  String formattedDate = formatter.format(now);

  print(formattedDate);
  return formattedDate;
}

