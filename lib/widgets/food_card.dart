import 'package:flutter/material.dart';

import '../models/food_model.dart';

class FoodCard extends StatelessWidget {
  final FoodModel food;
  final VoidCallback onTap;

  const FoodCard({super.key, required this.food, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        width: 180,
        margin: const EdgeInsets.only(right: 15),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(20),

          boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 10)],
        ),

        child: Column(
          children: [
            Hero(
              tag: food.name,

              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),

                child: Image.network(
                  food.image,
                  height: 130,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    food.name,

                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "\$${food.price}",
                    style: const TextStyle(color: Colors.orange, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
