import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_pizza/models/address.dart';
import 'package:flutter_pizza/models/topping.dart';
import 'package:http/http.dart' as http; //avoid name clash

import './cart.dart';

class OrderItem {
  final String id;
  final double amount; // quantity of item * price
  final List<CartItem> products;
  final DateTime dateTime;
  final AddressItem address;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
    @required this.address,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String authToken;
  final String userId;

  Orders(
    this.authToken,
    this.userId,
    this._orders,
  );

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url =
        'https://flutter-pizza-1c1e7-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken';
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['date']),
          address: AddressItem(
            addressId: orderData['address']['addressId'],
            apartment: orderData['address']['apartment'],
            cityName: orderData['address']['cityName'],
            floorNumber: orderData['address']['floorNumber'],
            streetName: orderData['address']['streetName'],
            streetNumber: orderData['address']['streetNumber'],
          ),
          products: (orderData['products'] as List<dynamic>)
              .map((item) => CartItem(
                    id: item['id'],
                    price: item['price'],
                    quantity: item['quantity'],
                    title: item['title'],
                    toppings: ((item['toppings']) as List<dynamic>)
                        .map((t) => Topping(t['name'], t['price']))
                        .toList(),
                  ))
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<OrderItem> addOrder(List<CartItem> cartProducts, double total,
      AddressItem userAddress) async {
    final timestamp = DateTime.now();
    final url =
        'https://flutter-pizza-1c1e7-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken';
    final response = await http.post(
      url,
      body: json.encode(
        {
          'amount': total,
          'date': timestamp.toIso8601String(),
          'address': {
            'addressId': userAddress.addressId,
            'cityName': userAddress.cityName,
            'streetName': userAddress.streetName,
            'streetNumber': userAddress.streetNumber,
            'floorNumber': userAddress.floorNumber,
            'apartment': userAddress.apartment,
          },
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                    'toppings': cp.toppings
                        .map((pizzaTop) => {
                              'name': pizzaTop.name,
                              'price': pizzaTop.price,
                            })
                        .toList(),
                  })
              .toList(),
        },
      ),
    );
    final OrderItem order = OrderItem(
      id: json.decode(response.body)['name'],
      amount: total,
      dateTime: timestamp,
      address: userAddress,
      products: cartProducts,
    );
    _orders.insert(0, order);
    notifyListeners();
    return order;
  }
}
