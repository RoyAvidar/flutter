import 'package:flutter/material.dart';
import '../providers/pizza.dart';

class Sale with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final List<Pizza> pizzas;

  Sale(
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    @required this.pizzas,
  );
}
