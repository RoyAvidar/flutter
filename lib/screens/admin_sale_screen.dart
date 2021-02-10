import 'package:flutter/material.dart';

class AdminSaleScreen extends StatefulWidget {
  static const routeName = '/admin-sale-form';
  @override
  _AdminSaleScreenState createState() => _AdminSaleScreenState();
}

class _AdminSaleScreenState extends State<AdminSaleScreen> {
  final _formKey = GlobalKey<FormState>();
  var _isLoading = false;
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
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      TextFormField(),
                      TextFormField(),
                      TextFormField(),
                      Table(),
                    ],
                  ),
                ),
              ));
  }
}
