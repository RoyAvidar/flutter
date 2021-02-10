import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/sale.dart';
import 'package:flutter_pizza/providers/pizzas_provider.dart';

class Sales with ChangeNotifier {
  List<Sale> _items = [];

  List<Sale> get items {
    return [..._items];
  }

  Sale findById(String id) {
    return _items.firstWhere((sale) => sale.id == id);
  }
}
