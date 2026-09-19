import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../services/order_service.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  Future<void> checkout(BuildContext context, CartProvider cart) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) return;

      final items = cart.items.map((item) {
        return {
          'name': item.food.name,

          'price': item.food.price,

          'quantity': item.quantity,
        };
      }).toList();

      await OrderService().placeOrder(
        userId: user.uid,

        userEmail: user.email ?? '',

        items: items,

        totalPrice: cart.totalPrice,
      );

      cart.clearCart();

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order Placed Successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Cart")),

      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return const Center(child: Text("Cart is Empty"));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,

                  itemBuilder: (context, index) {
                    final item = cart.items[index];

                    return Card(
                      margin: const EdgeInsets.all(10),

                      child: ListTile(
                        title: Text(item.food.name),

                        subtitle: Text("\$${item.food.price}"),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,

                          children: [
                            IconButton(
                              onPressed: () {
                                cart.decreaseQuantity(index);
                              },

                              icon: const Icon(Icons.remove),
                            ),

                            Text(item.quantity.toString()),

                            IconButton(
                              onPressed: () {
                                cart.increaseQuantity(index);
                              },

                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              Container(
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: [
                    Text(
                      "Total: \$${cart.totalPrice.toStringAsFixed(2)}",

                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,

                      child: ElevatedButton(
                        onPressed: () {
                          checkout(context, cart);
                        },

                        child: const Text("Checkout"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
