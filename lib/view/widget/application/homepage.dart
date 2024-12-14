import 'package:flutter/material.dart';
import 'package:frist_project/controller/application/cartcontroller.dart';
import 'package:frist_project/controller/application/product.dart';

import 'package:frist_project/view/screen/application/productesdetails.dart';

import 'package:get/get.dart';

class Homepagewidget extends StatelessWidget {
  final bool showFavoritesOnly;

  const Homepagewidget({required this.showFavoritesOnly, super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the Product controller

    Get.put(ProductcontrollerImp());
    final CartcontrollerImp cartController = Get.put(CartcontrollerImp());
    return GetBuilder<ProductcontrollerImp>(builder: (controller) {
      // Filter products based on whether to show favorites only
      final products = showFavoritesOnly
          ? controller.favoriteProducts // Show only favorite products
          : controller.loadedproducts; // Show all products

      return GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 25,
        ),
        itemCount: products.length, // Use filtered products list
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Get.to(Myproductdetails(
                id: products[index].id,
                title: products[index].title,
                description: products[index].description,
                imageUrl: products[index].imageUrl,
                price: products[index].price,
              ));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GridTile(
                footer: GridTileBar(
                  backgroundColor: Colors.black54,
                  title: Text(
                    '${products[index].title}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 10),
                  ),
                  leading: IconButton(
                    color:
                        products[index].isfavorite ? Colors.red : Colors.white,
                    onPressed: () {
                      // Toggle the favorite state for the specific product
                      controller.togglefavoritestate(
                          controller.loadedproducts.indexOf(products[index]));
                    },
                    icon: Icon(products[index].isfavorite
                        ? Icons.favorite
                        : Icons.favorite_border),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      final price = products[index]
                          .price; // This should be a non-nullable double
                      cartController.addToCart(
                        '${products[index].id}',
                        '${products[index].title}',
                        price!,
                      );
                      Get.snackbar(
                          'Cart', '${products[index].title} added to cart!',
                          snackPosition: SnackPosition.BOTTOM);
                    },
                    icon: const Icon(Icons.shopping_cart),
                  ),
                ),
                child: Image.asset(
                  '${products[index].imageUrl}', // Use filtered product image
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
