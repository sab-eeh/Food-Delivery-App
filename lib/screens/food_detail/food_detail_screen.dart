import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/food_model.dart';
import '../../providers/cart_provider.dart';

class FoodDetailScreen extends StatefulWidget {
  final FoodModel food;

  const FoodDetailScreen({super.key, required this.food});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int quantity = 1;
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.food.price * quantity;

    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [
          /// HERO IMAGE
          Stack(
            children: [
              Hero(
                tag: widget.food.name,

                child: Image.network(
                  widget.food.image,
                  height: 320,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              Positioned(
                top: 50,
                left: 15,

                child: CircleAvatar(
                  backgroundColor: Colors.white,

                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),

                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    widget.food.name,

                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: const [
                      Icon(Icons.star, color: Colors.amber),

                      SizedBox(width: 5),

                      Text(
                        "4.8",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      SizedBox(width: 10),

                      Text("(250 Reviews)"),
                    ],
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    widget.food.description,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Quantity",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },

                        icon: const Icon(Icons.remove_circle, size: 35),
                      ),

                      Text(
                        quantity.toString(),

                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },

                        icon: const Icon(
                          Icons.add_circle,
                          size: 35,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          const Text("Total Price"),

                          Text(
                            "\$${totalPrice.toStringAsFixed(2)}",

                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),

                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),

                        width: isAdded ? 220 : 180,

                        height: 55,

                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isAdded = true;
                            });

                            Provider.of<CartProvider>(
                              context,
                              listen: false,
                            ).addToCart(widget.food);

                            Future.delayed(const Duration(seconds: 1), () {
                              if (mounted) {
                                setState(() {
                                  isAdded = false;
                                });
                              }
                            });
                          },

                          child: Text(isAdded ? "Added ✓" : "Add To Cart"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
