import 'package:flutter/material.dart';

import '../models/cart_item_model.dart';
import '../models/food_model.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItemModel> _items = [];

  List<CartItemModel> get items => _items;

  void addToCart(FoodModel food) {
    int index = _items.indexWhere((item) => item.food.name == food.name);

    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItemModel(food: food));
    }

    notifyListeners();
  }

  void increaseQuantity(int index) {
    _items[index].quantity++;
    notifyListeners();
  }

  void decreaseQuantity(int index) {
    if (_items[index].quantity > 1) {
      _items[index].quantity--;
    } else {
      _items.removeAt(index);
    }

    notifyListeners();
  }

  double get totalPrice {
    double total = 0;

    for (var item in _items) {
      total += item.food.price * item.quantity;
    }

    return total;
  }

  void clearCart() {
    _items.clear();

    notifyListeners();
  }
}
