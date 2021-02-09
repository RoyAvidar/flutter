import 'package:flutter/material.dart';

class AddressItem {
  final String addressId;
  final String cityName;
  final String streetName;
  final int streetNumber;
  final int floorNumber;
  final int apartment;

  AddressItem({
    @required this.addressId,
    @required this.cityName,
    @required this.streetName,
    @required this.streetNumber,
    @required this.floorNumber,
    @required this.apartment,
  });
}
