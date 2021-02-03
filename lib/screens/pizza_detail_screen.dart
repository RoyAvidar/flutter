import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './cart_screen.dart';
import '../providers/pizzas_provider.dart';
import '../screens/pizza_edit_screen.dart';
import '../providers/cart.dart';
import '../widgets/badge.dart';

class PizzaDetailScreen extends StatelessWidget {
  static const routeName = '/pizza-detail';

  @override
  Widget build(BuildContext context) {
    final pizzaId = ModalRoute.of(context).settings.arguments as String;
    final loadedPizza = Provider.of<Pizzas>(
      context,
      listen: false,
    ).findById(pizzaId);
    final cart = Provider.of<Cart>(context, listen: false);
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(loadedPizza.title),
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 250,
              child: Image.network(
                loadedPizza.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                loadedPizza.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Toppings: ${loadedPizza.toppings.map((t) => t.name).join(",")}',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 17,
              ),
            ),
            SizedBox(height: 20),
            Text(
              '\$${loadedPizza.price}',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 15,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      PizzaEditScreen.routeName,
                      arguments: pizzaId,
                    );
                  },
                  child: Text('Edit Pizza'),
                ),
                SizedBox(width: 10),
                RaisedButton(
                  onPressed: () {
                    cart.addItem(loadedPizza.id, loadedPizza.price,
                        loadedPizza.title, loadedPizza.toppings);
                    _scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        content: Text('Added pizza to Cart!'),
                        duration: Duration(seconds: 2),
                        action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () {
                            cart.removeSingleItem(loadedPizza.id);
                          },
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Add To Cart',
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
