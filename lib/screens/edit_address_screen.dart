import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/address.dart';
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
  var _isInit = true;
  var _initValues = {
    'cityName': '',
    'streetName': '',
    'streetNumber': '',
  };

  Future<void> _saveAddressForm() async {
    final isValid =
        _formKey.currentState.validate(); //triggers all the validators
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_editedAddress.addressId != null) {
        await Provider.of<Address>(context, listen: false)
            .updateAddress(_editedAddress.addressId, _editedAddress);
      } else {
        await Provider.of<Address>(context, listen: false)
            .addAddress(_editedAddress);
      }
    } catch (error) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('Something went wrong.'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('Okay'),
            )
          ],
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final addressId = ModalRoute.of(context).settings.arguments as String;
      if (addressId != null) {
        _editedAddress =
            Provider.of<Address>(context, listen: false).findById(addressId);
        _initValues = {
          'cityName': _editedAddress.cityName,
          'streetName': _editedAddress.streetName,
          'streetNumber': _editedAddress.streetNumber.toString(),
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Your Address'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save_outlined),
            onPressed: _saveAddressForm, //_saveFrom method should run here
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
                      initialValue: _initValues['cityName'],
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
                      initialValue: _initValues['streetName'],
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
                      initialValue: _initValues['streetNumber'],
                      decoration: InputDecoration(labelText: 'Street Number'),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
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
