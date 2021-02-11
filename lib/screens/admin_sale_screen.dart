import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/pizzas_provider.dart';

class AdminSaleScreen extends StatefulWidget {
  static const routeName = '/admin-sale-form';
  @override
  _AdminSaleScreenState createState() => _AdminSaleScreenState();
}

class _AdminSaleScreenState extends State<AdminSaleScreen> {
  final _salesFormKey = GlobalKey<FormState>();
  var _isLoading = false;
  bool _checked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Sales'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              // onPressed: '_saveForm',
            )
          ],
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _salesFormKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'title',
                          border: OutlineInputBorder(),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide a value';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'description',
                          border: OutlineInputBorder(),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide a value';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Price',
                          border: OutlineInputBorder(),
                        ),
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
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                ),
              ));
  }
}
