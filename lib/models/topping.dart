import 'package:flutter/material.dart';

class Topping {
  String name;
  int price;

  Topping(this.name, this.price);
}

class Toppings extends ChangeNotifier {
  final peperoni = Topping('peperoni', 1);
  final bazil = Topping('peperoni', 1);
  final mushroom = Topping('peperoni', 1);
  final onion = Topping('peperoni', 1);
  final margherita = Topping('peperoni', 1);
}
