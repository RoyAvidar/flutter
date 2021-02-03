import 'package:flutter/material.dart';
import '../models/address.dart';

class Address with ChangeNotifier {
  Map<String, AddressItem> _addressMap = {};

  Map<String, AddressItem> get addressMap {
    return {..._addressMap};
  }

  int get addressCount {
    return _addressMap.length;
  }

  Future<void> addAddress(String addressId, String cityName, String streetName,
      int streetNumber) async {
    //adds an Address to the addressMap inside the FireBase
    _addressMap.putIfAbsent(
      addressId,
      () => AddressItem(
        addressId: DateTime.now().toString(),
        cityName: cityName,
        streetName: streetName,
        streetNumber: streetNumber,
      ),
    );
    notifyListeners();
  }

  Future<void> fetchAddress(String addressId) async {
    //fetching the addressMap from FireBase for that id
  }
}
