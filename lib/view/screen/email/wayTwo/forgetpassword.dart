import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final String firebaseApiKey = 'AIzaSyAqyO_OLjLLCGYji5NMM2vqFlrzWH4RGMA';

  ForgotPasswordPage({super.key});

  Future<void> _submitResetRequest() async {
    final email = _emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      Get.snackbar(
        'Invalid Email',
        'Please enter a valid email address.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    try {
      final url = Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=$firebaseApiKey');
      final response = await http.post(
        url,
        body: json.encode({
          'requestType': 'PASSWORD_RESET',
          'email': email,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Password reset link has been sent to $email.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
        );
        Get.offAllNamed('authScreen');
      } else {
        final error =
            responseData['error']['message'] ?? 'Unknown error occurred';
        if (error == 'EMAIL_NOT_FOUND') {
          Get.snackbar(
            'Error',
            'No account found with the provided email.',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.orange.withOpacity(0.8),
            colorText: Colors.white,
          );
        } else {
          Get.snackbar(
            'Error',
            'Failed to send reset link: $error',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red.withOpacity(0.8),
            colorText: Colors.white,
          );
        }
      }
    } catch (error) {
      Get.snackbar(
        'Error',
        'An error occurred. Please try again later.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forgot Password',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            Column(
              children: [
                const SizedBox(height: 80),
                const Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Enter your email address below to receive a password reset link.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitResetRequest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Send Reset Link',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Get.back(); // Navigate back to the previous page (login page).
                  },
                  child: const Text(
                    'Back to Login',
                    style: TextStyle(color: Colors.purple),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
