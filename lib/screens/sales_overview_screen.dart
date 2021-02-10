import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import './cart_screen.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../widgets/sales_grid.dart';

class SalesOverviewScreen extends StatefulWidget {
  @override
  _SalesOverviewScreenState createState() => _SalesOverviewScreenState();
  static const routeName = '/sales';
}

class _SalesOverviewScreenState extends State<SalesOverviewScreen> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sales'),
        actions: <Widget>[
          Consumer<Cart>(
            builder: (_, cartObject, ch) => Badge(
              child: ch,
              value: cartObject.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SalesGrid(),
    );
  }
}
