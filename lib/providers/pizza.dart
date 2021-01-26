import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/topping.dart';

class Pizza with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final List<Topping> toppings;
  bool isFavorite;

  Pizza({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    @required this.toppings,
    this.isFavorite = false,
  });

  Future<void> toggleFavorite() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url =
        'https://flutter-pizza-1c1e7-default-rtdb.firebaseio.com/pizzas/$id.json';
    try {
      await http.patch(
        url,
        body: json.encode({
          'isFavorite': isFavorite,
        }),
      );
    } catch (error) {
      isFavorite = oldStatus;
      notifyListeners();
    }
  }
}
