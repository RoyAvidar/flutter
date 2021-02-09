import 'package:flutter/material.dart';

class Topping {
  String name;
  int price;

  Topping(this.name, this.price);
}

class Toppings extends ChangeNotifier {
  final peperoni = Topping('peperoni', 5);
  final bazil = Topping('bazil', 3);
  final mushroom = Topping('mushroom', 2);
  final onion = Topping('onion', 3);
  final margherita = Topping('margherita', 1);
  final bacon = Topping('bacon', 7);
}
