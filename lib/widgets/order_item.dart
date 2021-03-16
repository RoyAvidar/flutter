import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  OrderItem({this.order});

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    var products = widget.order.products;
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      height:
          _expanded ? min(widget.order.products.length * 40.0 + 200, 200) : 95,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('Total: \$${widget.order.amount.toStringAsFixed(2)}'),
              subtitle: Text(
                DateFormat('dd/MM/yyyy  hh:mm').format(widget.order.dateTime),
              ),
              trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: _expanded
                  ? min(widget.order.products.length * 25.0 + 75, 100)
                  : 0,
              child: ListView(
                children: [
                  ...widget.order.products
                      .map(
                        (prod) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              prod.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            SizedBox(height: 7),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Quantity: ${prod.quantity}',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 7),
                                Text(
                                  'Price: \$${prod.price}',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 7),
                                Text(
                                  'Toppings: ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                                Text(
                                    'Name: ${prod.toppings.map((t) => t.name).join(",")}'),
                                SizedBox(height: 7),
                                Text(
                                    'Price: \$${prod.toppings.map((t) => t.price).join(",")}'),
                                Divider(
                                  height: 8,
                                  thickness: 4,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                      .toList(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Address: ',
                        style: TextStyle(
                            fontSize: 16, color: Theme.of(context).accentColor),
                      ),
                      SizedBox(height: 10),
                      Text('City: ${widget.order.address.cityName}'),
                      SizedBox(height: 5),
                      Text('Street: ${widget.order.address.streetName}'),
                      SizedBox(height: 5),
                      Text('Number: ${widget.order.address.streetNumber}'),
                      SizedBox(height: 5),
                      Text('Floor: ${widget.order.address.floorNumber}'),
                      SizedBox(height: 5),
                      Text('Apartment: ${widget.order.address.apartment}'),
                      SizedBox(height: 5),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
