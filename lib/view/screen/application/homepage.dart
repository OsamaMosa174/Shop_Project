import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:frist_project/controller/application/product.dart';

import 'package:frist_project/core/function/alertexitapp.dart';

import 'package:frist_project/view/widget/application/homepage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Filteroptions {
  // ignore: constant_identifier_names
  Favorites,
  // ignore: constant_identifier_names
  All
}

class MyHomepage extends StatefulWidget {
  const MyHomepage({super.key});

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  bool showFavoritesOnly = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          User? user = snapshot.data;
          String userEmail = user != null ? user.email ?? 'No Email' : 'Guest';
          print('User: $user');
          Get.put(ProductcontrollerImp());

          return Scaffold(
              drawer: Drawer(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 60,
                            width: 60,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.asset(
                                'assets/images/robot.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(user?.displayName ?? 'User'),
                              subtitle: Text(userEmail),
                            ),
                          )
                        ],
                      ),
                      ListTile(
                        title: const Text('homepage'),
                        leading: const Icon(Icons.home),
                        onTap: () {
                          Get.offAllNamed('homepage');
                        },
                      ),
                      ListTile(
                        title: const Text('Account'),
                        leading: const Icon(Icons.account_balance_rounded),
                        onTap: () {},
                      ),
                      ListTile(
                        title: const Text('Order'),
                        leading: const Icon(Icons.shopping_cart),
                        onTap: () {
                          Get.toNamed('cartscreen');
                        },
                      ),
                      ListTile(
                        title: const Text('About Us'),
                        leading: const Icon(Icons.help),
                        onTap: () {},
                      ),
                      ListTile(
                        title: const Text('contact Us'),
                        leading: const Icon(Icons.phone_android_outlined),
                        onTap: () {},
                      ),
                      ListTile(
                        title: const Text('Sign out'),
                        leading: const Icon(Icons.exit_to_app),
                        onTap: () {
                          _logoutUser();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.blue,
                // leading: Drawer(
                //   child: IconButton(onPressed: () {}, icon: const Icon(Icons.list)),
                // ),
                title: const Text(
                  'Shop App',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        Get.toNamed('cartscreen');
                      },
                      icon: const Icon(Icons.shopping_cart)),
                  PopupMenuButton(
                    onSelected: (Filteroptions selectedValue) {
                      setState(() {
                        if (selectedValue == Filteroptions.Favorites) {
                          showFavoritesOnly =
                              true; // Show only favorite products
                        } else {
                          showFavoritesOnly = false; // Show all products
                        }
                      });
                    },
                    itemBuilder: (_) => [
                      const PopupMenuItem(
                        value: Filteroptions.Favorites,
                        child: Text('Only Favorites'),
                      ),
                      const PopupMenuItem(
                        value: Filteroptions.All,
                        child: Text('Show All'),
                      ),
                    ],
                    icon: const Icon(Icons.more_vert),
                  ),
                ],
              ),
              // ignore: deprecated_member_use
              body: WillPopScope(
                  onWillPop: alertExitApp,
                  child: Homepagewidget(showFavoritesOnly: showFavoritesOnly)));
        });
  }

  Future<void> _logoutUser() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false); // Set user as logged out
    Get.offAllNamed('authScreen'); // Navigate to login/auth screen
  }
}
