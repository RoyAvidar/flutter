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
    this.toppings,
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

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  double get totalPrice {
    var totalPrice = 0.0;
    _items.forEach((key, cartItem) {
      totalPrice += double.parse(cartItem.toppings.toString()) + cartItem.price;
    });
    return totalPrice;
  }

  void addSaleItem(
      String saleId, double salePrice, String title, List<Topping> toppings) {
    if (_items.containsKey(saleId)) {
      _items.update(saleId, (existingCartItem) {
        return CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          quantity: existingCartItem.quantity + 1,
          price: existingCartItem.price,
          toppings: existingCartItem.toppings,
        );
      });
    } else {
      _items.putIfAbsent(
        saleId,
        () => CartItem(
          id: DateTime.now().toString(),
          price: salePrice,
          title: title,
          quantity: 1,
          toppings: toppings,
        ),
      );
    }
    notifyListeners();
  }

  void addItem(
      String pizzaId, double price, String title, List<Topping> toppings) {
    if (_items.containsKey(pizzaId)) {
      //cahnge quantity..
      _items.update(pizzaId, (existingCartItem) {
        return CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          quantity: existingCartItem.quantity,
          price: existingCartItem.price,
          toppings: existingCartItem.toppings,
        );
      });
    } else {
      print(toppings.length);
      if (toppings.length > 1) {
        for (var topp in toppings) {
          var prices = topp.price;
          price += prices;
        }
      }
      _items.putIfAbsent(
        pizzaId,
        () => CartItem(
          id: DateTime.now().toString(),
          price: price,
          title: title,
          toppings: toppings,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void cahngeQuantity(String pizzaid) {
    _items.update(
      pizzaid,
      (exsitingCartItem) => CartItem(
        id: exsitingCartItem.id,
        title: exsitingCartItem.title,
        quantity: exsitingCartItem.quantity + 1,
        price: exsitingCartItem.price,
        toppings: exsitingCartItem.toppings,
      ),
    );
    notifyListeners();
  }

  void removeItem(String pizzaId) {
    _items.remove(pizzaId);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }

  void removeSingleItem(String pizzaId) {
    if (!_items.containsKey(pizzaId)) {
      return;
    }
    if (_items[pizzaId].quantity > 1) {
      _items.update(
        pizzaId,
        (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            quantity: existingCartItem.quantity - 1,
            price: existingCartItem.price,
            toppings: existingCartItem.toppings),
      );
    } else {
      _items.remove(pizzaId);
    }
    notifyListeners();
  }
}
