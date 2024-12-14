import 'package:frist_project/view/screen/application/cartscreen.dart';
import 'package:frist_project/view/screen/application/homepage.dart';

//import 'package:frist_project/view/screen/application/productesdetails.dart';

import 'package:frist_project/view/screen/email/wayTwo/auth.dart';
import 'package:frist_project/view/screen/email/wayTwo/forgetpassword.dart';

import 'package:get/get_navigation/src/routes/get_route.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: '/homepage', page: () => const MyHomepage()),
  GetPage(name: '/cartscreen', page: () => const MYCartScreen()),
  GetPage(name: '/authScreen', page: () => const MYAuthScreen()),
  GetPage(name: '/ForgotPasswordPage', page: () => ForgotPasswordPage()),
];
