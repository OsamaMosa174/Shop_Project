import 'package:flutter/material.dart';
import 'package:frist_project/core/class/addtocart.dart';
import 'package:get/get.dart';

import 'dart:convert'; // For json encoding
import 'package:http/http.dart' as http; // For making HTTP requests

class CartcontrollerImp extends GetxController {
  var items = {}.obs;

  void addToCart(String productId, String title, double price) {
    if (items.containsKey(productId)) {
      items[productId]!.quantity += 1; // Increment quantity
    } else {
      items[productId] =
          CartItem(id: productId, title: title, price: price); // Add new item
    }
    update();
  }

  void removeFromCart(String productId) {
    if (items.containsKey(productId)) {
      items.remove(productId); // Remove item from cart
      update();
    }
  }

  Future<void> saveCart() async {
    final cartItems = items.values.map((item) => item.toJson()).toList();
    final jsonBody = json.encode(cartItems);

    final response = await http.post(
      Uri.parse(
          'https://shop-app-8b4d1-default-rtdb.firebaseio.com/products.json'),
      headers: {'Content-Type': 'application/json'},
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      items.clear();
      Get.snackbar('Success', 'Your order is on the way!',
          backgroundColor: Colors.green);
      Get.toNamed('homepage');
    } else {
      Get.snackbar('Error', 'Failed to buy. Please try again.',
          backgroundColor: Colors.red);
    }
  }

  int get itemCount => items.length;

  bool isInCart(String productId) {
    return items.containsKey(productId);
  }

  double get totalPrice {
    double total = 0.0;
    items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }
}
