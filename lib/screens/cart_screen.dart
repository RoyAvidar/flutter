import 'package:flutter/material.dart';
import 'package:flutter_pizza/models/address.dart';
import 'package:provider/provider.dart';

import '../screens/order_confirmation_screen.dart';
import '../screens/pick_address_screen.dart';
import '../providers/orders.dart';
import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline1
                              .color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  ClearButton(cart: cart),
                  OrderButton(cart: cart)
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (ctx, i) => CartItem(
                cart.items.values.toList()[i].id,
                cart.items.keys.toList()[i], // passing the key in cart_item
                cart.items.values.toList()[i].price,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].title,
                cart.items.values.toList()[i].toppings,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
    this.pickedAddress,
  }) : super(key: key);

  final Cart cart;
  final AddressItem pickedAddress;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  bool isPicking = true;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: _isLoading ? CircularProgressIndicator() : Text('Order Now'),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              final address = await Navigator.of(context).pushNamed(
                PickAddressScreen.routeName,
                arguments: isPicking,
              );
              if (address == null) {
                return Text('pick an address');
              }

              final orderItem =
                  await Provider.of<Orders>(context, listen: false).addOrder(
                widget.cart.items.values.toList(),
                widget.cart.totalAmount,
                address,
              );
              setState(() {
                _isLoading = false;
              });
              widget.cart.clearCart();
              Navigator.pushNamed(
                context,
                OrderConfirmationScreen.routeName,
                arguments: orderItem,
              );
            },
      textColor: Theme.of(context).primaryColor,
    );
  }
}

class ClearButton extends StatefulWidget {
  ClearButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _ClearButtonState createState() => _ClearButtonState();
}

class _ClearButtonState extends State<ClearButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: _isLoading ? CircularProgressIndicator() : Text('Clear Cart'),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              Provider.of<Cart>(context, listen: false).clearCart();
              setState(() {
                _isLoading = false;
              });
            },
      textColor: Theme.of(context).accentColor,
    );
  }
}
