import 'package:flutter/material.dart';
import 'package:flutter_pizza/models/address.dart';

import '../widgets/app_drawer.dart';

class OrderConfirmationScreen extends StatelessWidget {
  static const routeName = '/order-confirmation';
  @override
  Widget build(BuildContext context) {
    final address = ModalRoute.of(context).settings.arguments as AddressItem;
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Confirmation'),
      ),
      drawer: AppDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              'Pizza\'le',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(15)),
          Text('Your order is on the way!'),
          SizedBox(height: 10),
          Text('address information: '),
          Text('${address.cityName}'),
          Text('${address.streetName}'),
          Text('${address.streetNumber} , ${address.floorNumber}'),
          Divider(thickness: 3),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('orderItem info inside a row + total amount'),
              ],
            ),
          ),
          SizedBox(height: 50),
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).pushNamed('/');
            },
          ),
          SizedBox(height: 15),
          Text('Have questions? Just reply to this email'),
        ],
      ),
    );
  }
}
