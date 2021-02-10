import 'package:flutter/material.dart';

import '../models/sale.dart';

class Sales with ChangeNotifier {
  List<Sale> _items = [SalesList().summersSale];

  List<Sale> get items {
    return [..._items];
  }

  Sale findById(String id) {
    return _items.firstWhere((sale) => sale.id == id);
  }
}
