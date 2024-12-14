import 'package:flutter/material.dart';
import 'package:frist_project/controller/application/cartcontroller.dart';
import 'package:frist_project/controller/application/product.dart';

import 'package:get/get.dart';

class Myproductdetails extends StatelessWidget {
  final String? id;
  final String? title;
  final String? description;
  final String? imageUrl;
  final double? price;

  const Myproductdetails({
    super.key,
    required this.title,
    required this.id,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(ProductcontrollerImp());
    final CartcontrollerImp cartController = Get.put(CartcontrollerImp());

    // Use default values if the parameters are null
    final productId = id ?? 'Unknown ID';
    final productTitle = title ?? 'No Title';
    final productDescription = description ?? 'No Description';
    final productImageUrl =
        imageUrl ?? 'assets/default_image.png'; // Provide a default image
    final productPrice = price ?? 0.0; // Provide a default price

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: const Text('Product Details',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Text(
                productTitle,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              child: Image.asset(productImageUrl),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              alignment: Alignment.center,
              child: Text(
                productDescription,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 120),
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Price:'),
                  Text(
                    '$productPrice',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  const Text('\$')
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              alignment: Alignment.center,
              child: ClipRRect(
                child: Obx(() {
                  // Check if the product is in the cart
                  final isInCart = cartController.isInCart(productId);

                  return MaterialButton(
                    color: isInCart
                        ? Colors.red
                        : Colors.blue, // Red for remove, blue for add
                    onPressed: () {
                      if (isInCart) {
                        cartController.removeFromCart(productId);
                        Get.snackbar(
                          'Cart',
                          '$productTitle removed from cart!',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      } else {
                        cartController.addToCart(
                          productId,
                          productTitle,
                          productPrice,
                        );
                        Get.snackbar(
                          'Cart',
                          '$productTitle added to cart!',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                    child: Text(
                      isInCart ? 'Remove from Cart' : 'Add to Cart',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
