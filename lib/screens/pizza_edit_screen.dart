import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/pizzas_provider.dart';
import '../providers/cart.dart';
import '../widgets/badge.dart';
import '../screens/cart_screen.dart';
import '../widgets/pizza_circle.dart';

class PizzaEditScreen extends StatefulWidget {
  static const routeName = '/pizza-edit';
  @override
  _PizzaEditScreenState createState() => _PizzaEditScreenState();
}

class _PizzaEditScreenState extends State<PizzaEditScreen> {
  @override
  Widget build(BuildContext context) {
    final pizzaId = ModalRoute.of(context).settings.arguments as String;
    final loadedPizza = Provider.of<Pizzas>(
      context,
      listen: false,
    ).findById(pizzaId);
    return Scaffold(
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
      body: PizzaCircle(),
    );
  }
}
