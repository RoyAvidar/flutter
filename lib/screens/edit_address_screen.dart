import 'package:flutter/material.dart';

class EditAddressScreen extends StatefulWidget {
  static const routeName = '/edit-address-screen';
  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
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
                  children: <Widget>[TextFormField()],
                ),
              ),
            ),
    );
  }
}
