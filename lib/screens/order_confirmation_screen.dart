import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';

class OrderConfirmationScreen extends StatelessWidget {
  static const routeName = '/order-confirmation';
  @override
  Widget build(BuildContext context) {
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
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Text('Thank you for your order!'),
          Container(
            child: Text('address information'),
          ),
          Divider(thickness: 4),
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
            onPressed: null,
          ),
          SizedBox(height: 15),
          Text('Have questions? Just reply to this email'),
        ],
      ),
    );
  }
}
