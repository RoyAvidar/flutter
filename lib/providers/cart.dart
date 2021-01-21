import 'package:flutter/material.dart';
import '../models/topping.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final List<Topping> toppings;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
    @required this.toppings,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(
      String pizzaId, double price, String title, List<Topping> toppings) {
    if (_items.containsKey(pizzaId)) {
      //cahnge quantity..
      _items.update(
        pizzaId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          quantity: existingCartItem.quantity + 1,
          price: existingCartItem.price,
          toppings: existingCartItem.toppings,
        ),
      );
    } else {
      _items.putIfAbsent(
        pizzaId,
        () => CartItem(
          id: DateTime.now().toString(),
          price: price,
          title: title,
          toppings: [],
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }
}
