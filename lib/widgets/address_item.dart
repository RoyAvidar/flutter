import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressItemWidget extends StatelessWidget {
  final String addressId;
  final String cityName;
  final String streetName;
  final int streetNumber;

  AddressItemWidget(
    this.addressId,
    this.cityName,
    this.streetName,
    this.streetNumber,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text('working'),
    );
  }
}
