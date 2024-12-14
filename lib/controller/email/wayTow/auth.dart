import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthImp extends GetxController {
  // ignore: unused_field
  late String _token;
  // ignore: unused_field
  late DateTime _expirydate;
  // ignore: unused_field
  late String _userID;

  Future<void> signup(String email, String password) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAqyO_OLjLLCGYji5NMM2vqFlrzWH4RGMA');
    try {
      // ignore: unused_local_variable
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final responsdata = json.decode(response.body);
      if (responsdata['error'] != null) {
        throw HttpException(responsdata['error']['message']);
      }
      Get.snackbar(
        'Signup Successful', // Title
        'You have successfully created an account!', // Message
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      Get.offAllNamed('authScreen');
    } catch (error) {
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAqyO_OLjLLCGYji5NMM2vqFlrzWH4RGMA');
    // ignore: unused_local_variable

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }),
      );
      final responsdata = json.decode(response.body);
      if (responsdata['error'] != null) {
        throw HttpException(responsdata['error']['message']);
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      Get.offAllNamed('homepage');
    } catch (error) {
      rethrow;
    }
  }
}
