import 'package:flutter/material.dart';
import 'package:frist_project/services/services.dart';
import 'package:get/get.dart';

class Middleware extends GetMiddleware {
  @override
  int? get priority => 1;

  Myservices myservices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (myservices.sharedPreferences.getString('onbording') == '1') {
      return const RouteSettings(name: 'login');
    }
    return null;
  }
}
