import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frist_project/roots.dart';
import 'package:frist_project/services/services.dart';

import 'package:frist_project/view/screen/application/homepage.dart';
import 'package:frist_project/view/screen/email/wayTwo/auth.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: 'key',
      appId: 'id',
      messagingSenderId: 'sendid',
      projectId: 'myapp',
      storageBucket: 'myapp-b9yt18.appspot.com',
    ));

    await initialServices();
  } catch (e) {
    return;
  }
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(Myservices());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.blue),
      ),
      home: const CheckAuth(),
      getPages: routes,
    );
  }
}

class CheckAuth extends StatelessWidget {
  const CheckAuth({super.key});

  Future<bool> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong!'));
        }

        if (snapshot.data == true) {
          return const MyHomepage();
        } else {
          return const MYAuthScreen();
        }
      },
    );
  }
}
