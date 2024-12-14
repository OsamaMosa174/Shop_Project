import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', true);
}
