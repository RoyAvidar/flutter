import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/address.dart';
import '../widgets/address_item.dart';

class Address with ChangeNotifier {
  //Address(this._authToken, this._expiryDate, this._userId);
  List<AddressItem> _addressList = [];
  final String _authToken;
  final String _userId;

  Address(this._authToken, this._userId, this._addressList);

  List<AddressItem> get addressList {
    return [..._addressList];
  }

  int get addressCount {
    return _addressList.length;
  }

  String get userId {
    return _userId;
  }

  Future<void> addAddress(AddressItem address) async {
    //adds an Address to the addressMap inside the FireBase
    final url =
        'https://flutter-pizza-1c1e7-default-rtdb.firebaseio.com/users-$_userId.json?auth=$_authToken';
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

  Future<void> fetchAddress() async {
    //fetching the addressMap from FireBase for that id
    final url =
        'https://flutter-pizza-1c1e7-default-rtdb.firebaseio.com/users-$_userId.json?auth=$_authToken';
    final response = await http.get(url);
    final List<AddressItem> loadedAddress = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((addressId, addressData) {
      loadedAddress.add(
        AddressItem(
          addressId: addressId,
          cityName: addressData['cityName'],
          streetName: addressData['streetName'],
          streetNumber: addressData['streetNumber'],
        ),
      );
    });
    _addressList = loadedAddress.reversed.toList();
    notifyListeners();
  }
}
