import 'package:flutter/material.dart';

class AddressItem {
  final String addressId;
  final String cityName;
  final String streetName;
  final int streetNumber;

  AddressItem({
    @required this.addressId,
    @required this.cityName,
    @required this.streetName,
    @required this.streetNumber,
  });
}
