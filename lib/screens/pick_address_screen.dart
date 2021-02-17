import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class PickAddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick an Address'),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text('Choose an Address'),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FutureBuilder(
            builder: null,
          ), //should be a list of address's that the user will pick from
        ],
      ),
    );
  }
}
