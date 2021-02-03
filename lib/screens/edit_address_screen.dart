import 'package:flutter/material.dart';
import 'package:flutter_pizza/providers/address.dart';
import '../models/address.dart';

class EditAddressScreen extends StatefulWidget {
  static const routeName = '/edit-address-screen';
  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  var _editedAddress = AddressItem(
    addressId: null,
    cityName: '',
    streetName: '',
    streetNumber: 0,
  );
  final _formKey = GlobalKey<FormState>();
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Your Address'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save_outlined),
            onPressed: null, //_saveFrom method should run here
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'City Name'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedAddress = AddressItem(
                          addressId: _editedAddress.addressId,
                          cityName: value,
                          streetName: _editedAddress.streetName,
                          streetNumber: _editedAddress.streetNumber,
                        );
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Street Name'),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedAddress = AddressItem(
                          addressId: _editedAddress.addressId,
                          cityName: _editedAddress.cityName,
                          streetName: value,
                          streetNumber: _editedAddress.streetNumber,
                        );
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Street Number'),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedAddress = AddressItem(
                          addressId: _editedAddress.addressId,
                          cityName: _editedAddress.cityName,
                          streetName: _editedAddress.streetName,
                          streetNumber: int.parse(value),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
