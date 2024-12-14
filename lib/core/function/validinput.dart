import 'package:get/get.dart';

validinput(String val, int min, int max, String type) {
  if (type == 'username') {
    if (!GetUtils.isUsername(val)) {
      return 'not valide username';
    }
  }

  if (type == 'email') {
    if (!GetUtils.isEmail(val)) {
      return 'not valide email';
    }
  }

  if (type == 'phone') {
    if (!GetUtils.isPhoneNumber(val)) {
      return 'not valide phone';
    }
  }
  if (val.isEmpty) {
    return "can't be Empty";
  }
  if (val.length < min) {
    return "can't be less than $min";
  }
  if (val.length > max) {
    return "can't be larger than $max";
  }
}
