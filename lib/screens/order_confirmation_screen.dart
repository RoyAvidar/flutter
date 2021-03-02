import 'package:flutter/material.dart';

import '../screens/orders_screen.dart';
import '../providers/orders.dart';
import '../widgets/app_drawer.dart';

class OrderConfirmationScreen extends StatelessWidget {
  static const routeName = '/order-confirmation';
  @override
  Widget build(BuildContext context) {
    final orderItem = ModalRoute.of(context).settings.arguments as OrderItem;
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
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(15)),
          Text('Your order is on the way!'),
          SizedBox(height: 10),
          Text(
            'address information: ',
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          Text('${orderItem.address.cityName}'),
          Text('${orderItem.address.streetName}'),
          Text(
              '${orderItem.address.streetNumber} , ${orderItem.address.floorNumber}'),
          Divider(thickness: 3),
          Text(
            'Order information: ',
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          Expanded(
            child: SizedBox(
              height: 15,
              child: ListView(
                children: orderItem.products
                    .map(
                      (prod) => Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('${prod.title}'),
                              Text('\$ ${prod.price}'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                  '${prod.toppings.map((t) => t.name).join(",")}'),
                              Text(
                                  '\$ ${prod.toppings.map((t) => t.price).join(",")}'),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Quantity: '),
                              Text('${prod.quantity}'),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Total: '),
                              Text('Total: \$ ${prod.price * prod.quantity}'),
                            ],
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).pushNamed('/');
            },
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(OrdersScreen.routeName);
            },
            child: Text('Go to My Orders'),
          ),
        ],
      ),
    );
  }
}
