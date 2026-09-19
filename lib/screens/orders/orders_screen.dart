import 'package:flutter/material.dart';

import '../../models/order_model.dart';
import '../../services/order_service.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Orders")),

      body: FutureBuilder<List<OrderModel>>(
        future: OrderService().getUserOrders(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No Orders Found"));
          }

          final orders = snapshot.data!;

          return ListView.builder(
            itemCount: orders.length,

            itemBuilder: (context, index) {
              final order = orders[index];

              return Card(
                margin: const EdgeInsets.all(12),

                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.receipt)),

                  title: Text("Order #${order.id.substring(0, 6)}"),

                  subtitle: Text("Total: \$${order.totalPrice}"),

                  trailing: Chip(label: Text(order.status)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
