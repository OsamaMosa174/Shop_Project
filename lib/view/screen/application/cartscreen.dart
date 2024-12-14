import 'package:flutter/material.dart';

import 'package:frist_project/controller/application/cartcontroller.dart';
import 'package:frist_project/core/class/addtocart.dart';
import 'package:get/get.dart';

class MYCartScreen extends StatelessWidget {
  const MYCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartcontrollerImp cartController = Get.find<CartcontrollerImp>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: GetBuilder<CartcontrollerImp>(builder: (controller) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartController.items.length,
                itemBuilder: (context, index) {
                  String key = cartController.items.keys.toList()[index];
                  CartItem? item = cartController.items[key]; // Nullable item

                  if (item == null) {
                    return const SizedBox.shrink(); // Handle null case
                  }

                  return Card(
                    child: ListTile(
                      title: Text(item.title),
                      subtitle: Text('Quantity: ${item.quantity}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              cartController.removeFromCart(
                                  item.id); // Remove item from cart
                            },
                          ),
                          Text(
                              'Total: \$${(item.price * item.quantity).toStringAsFixed(2)}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Text('Total: \$${cartController.totalPrice.toStringAsFixed(2)}'),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: MaterialButton(
                  minWidth: 150,
                  color: Colors.blue,
                  onPressed: () async {
                    await cartController.saveCart(); // Save and clear cart
                  },
                  child:
                      const Text('buy', style: TextStyle(color: Colors.white)),
                ))
          ],
        );
      }),
    );
  }
}
