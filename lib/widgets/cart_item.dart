import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../models/topping.dart';

class CartItem extends StatefulWidget {
  final String id;
  final String pizzaId;
  final double price;
  final int quantity;
  final String title;
  final List<Topping> toppings;

  CartItem(
    this.id,
    this.pizzaId,
    this.price,
    this.quantity,
    this.title,
    this.toppings,
  );

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Theme.of(context).buttonColor,
          size: 30,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 8,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to remove the pizza from the cart?'),
            actions: <Widget>[
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              )
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(widget.pizzaId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: FittedBox(
                      child: Text('\$${widget.price}'),
                    ),
                  ),
                ),
                title: Text(widget.title),
                subtitle: Text('${widget.quantity} x'),
                trailing: IconButton(
                  icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                ),
              ),
              if (_expanded)
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                      child: Text('Total: ${widget.price * widget.quantity}'),
                      alignment: Alignment.topLeft,
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                      child: Text(
                          'Toppings: ${widget.toppings.map((t) => t.name).join(",")}'),
                      alignment: Alignment.topLeft,
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                      child: Text(
                          'Toppings Pirce: ${widget.toppings.map((t) => t.price).join(",")}'),
                      alignment: Alignment.topLeft,
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
