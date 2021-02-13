import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/topping.dart';
import '../models/sale.dart';

class Pizza with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final List<Topping> toppings;
  bool isFavorite;
  Sale sale;
  double salePrice;
  bool isOnSale;

  Pizza({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    @required this.toppings,
    this.salePrice,
    this.isFavorite = false,
    this.isOnSale = false,
    this.sale,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavorite(String token, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url =
        'https://flutter-pizza-1c1e7-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    try {
      final response = await http.put(
        url,
        body: json.encode(
          isFavorite,
        ),
      );
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
      print(error);
    }
  }

  void _setOnSaleValue(bool newValue) {
    isOnSale = newValue;
    notifyListeners();
  }

  Future<void> toggleIsOnSale(String token) async {
    var url =
        'https://flutter-pizza-1c1e7-default-rtdb.firebaseio.com/pizza.json?auth=$token';
    final oldStatus = isOnSale;
    isOnSale = !isOnSale;
    notifyListeners();
    try {
      final response = await http.put(
        url,
        body: json.encode(
          isOnSale,
        ),
      );
      if (response.statusCode >= 400) {
        _setOnSaleValue(oldStatus);
      }
    } catch (error) {
      _setOnSaleValue(oldStatus);
      print(error);
    }
  }
}
