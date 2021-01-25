import 'package:flutter/material.dart';
import 'package:flutter_pizza/models/topping.dart';
import 'package:flutter_pizza/providers/pizza.dart';
import '../screens/pizza_detail_screen.dart';
import '../providers/cart.dart';

import 'package:provider/provider.dart';

class PizzaItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pizza = Provider.of<Pizza>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              PizzaDetailScreen.routeName,
              arguments: pizza.id,
            );
          },
          child: Image.network(
            pizza.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: IconButton(
            icon: Icon(
              pizza.isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            color: Theme.of(context).accentColor,
            onPressed: () {
              pizza.toggleFavorite();
            },
          ),
          backgroundColor: Colors.black54,
          title: Text(
            pizza.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: () {
              cart.addItem(
                pizza.id,
                pizza.price,
                pizza.title,
                pizza.toppings,
              );
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Added pizza to Cart!'),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    cart.removeSingleItem(pizza.id);
                  },
                ),
              ));
            },
          ),
        ),
      ),
    );
  }
}
