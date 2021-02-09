import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';
import '../models/address.dart';

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

  AddressItem findById(String id) {
    return _addressList.firstWhere((add) => add.addressId == id);
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
          'floorNumber': address.floorNumber,
          'apartment': address.apartment,
        }),
      );
      final newAddress = AddressItem(
        addressId: json.decode(response.body)['name'],
        cityName: address.cityName,
        streetName: address.streetName,
        streetNumber: address.streetNumber,
        floorNumber: address.floorNumber,
        apartment: address.apartment,
      );
      // addressList.add(newAddress);
      _addressList.add(newAddress);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchAddress() async {
    //fetching the addressMap from FireBase for that id
    _addressList = [];
    final url =
        'https://flutter-pizza-1c1e7-default-rtdb.firebaseio.com/users-$_userId.json?auth=$_authToken';
    final response = await http.get(url);
    final List<AddressItem> loadedAddress = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((addressId, addressData) {
      if (addressData['admin'] == null) {
        loadedAddress.add(
          AddressItem(
            addressId: addressId,
            cityName: addressData['cityName'],
            streetName: addressData['streetName'],
            streetNumber: addressData['streetNumber'],
            floorNumber: addressData['floorNumber'],
            apartment: addressData['apartment'],
          ),
        );
        _addressList = loadedAddress.reversed.toList();
      }
    });
    notifyListeners();
  }

  Future<void> updateAddress(String id, AddressItem newAddress) async {
    final addressIndex =
        _addressList.indexWhere((adrs) => adrs.addressId == id);
    if (addressIndex >= 0) {
      final url =
          'https://flutter-pizza-1c1e7-default-rtdb.firebaseio.com/users-$_userId/$id.json?auth=$_authToken';
      await http.patch(url,
          body: json.encode({
            'cityName': newAddress.cityName,
            'streetName': newAddress.streetName,
            'streetNumber': newAddress.streetNumber,
            'floorNumber': newAddress.floorNumber,
            'apartment': newAddress.apartment,
          }));
      _addressList[addressIndex] = newAddress;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteAddress(String id) async {
    final url =
        'https://flutter-pizza-1c1e7-default-rtdb.firebaseio.com/users-$_userId/$id.json?auth=$_authToken';
    final addressIndex = _addressList.indexWhere((add) => add.addressId == id);
    var existingAddress = _addressList[addressIndex];
    _addressList.remove(existingAddress);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _addressList.insert(addressIndex, existingAddress);
      notifyListeners();
      throw HttpException('Could not delete this address');
    }
    existingAddress = null;
  }
}
