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
    this.id,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.pizzas,
  );
}

class SalesList with ChangeNotifier {
  final summersSale = Sale(
      '1',
      'Summer Sale',
      'description',
      79.99,
      'http://www.pizzanearme.com/sites/default/files/field/image/2%20pizzas.jpg',
      []);
}
