import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/address.dart';
import '../widgets/address_item.dart';

class Address with ChangeNotifier {
  List<AddressItem> _addressList = [];

  List<AddressItem> get addressList {
    return [..._addressList];
  }

  int get addressCount {
    return _addressList.length;
  }

  final String authToken;

  Address({
    this.authToken,
  });

  Future<void> addAddress(AddressItem address) async {
    //adds an Address to the addressMap inside the FireBase
    final url =
        'https://flutter-pizza-1c1e7-default-rtdb.firebaseio.com/address.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'cityName': address.cityName,
          'streetName': address.streetName,
          'streetNumber': address.streetNumber,
        }),
      );
      final newAddress = AddressItem(
        addressId: json.decode(response.body)['name'],
        cityName: address.cityName,
        streetName: address.streetName,
        streetNumber: address.streetNumber,
      );
      addressList.add(newAddress);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchAddress(String addressId) async {
    //fetching the addressMap from FireBase for that id
  }
}
