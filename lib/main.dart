import 'package:flutter/material.dart';
import 'package:flutter_pizza/screens/pizza_edit_screen.dart';
import 'package:provider/provider.dart';

import './screens/orders_screen.dart';
import './screens/cart_screen.dart';
import './screens/pizza_overview_screen.dart';
import './screens/pizza_detail_screen.dart';
import './providers/pizzas_provider.dart';
import './providers/cart.dart';
import './providers/orders.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Pizzas(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        )
      ],
      child: MaterialApp(
        title: 'Pizza Time',
        theme: ThemeData(
          primaryColor: Colors.yellow[800],
          accentColor: Colors.red,
        ),
        home: PizzaOverviewScreen(),
        routes: {
          PizzaDetailScreen.routeName: (ctx) => PizzaDetailScreen(),
          PizzaEditScreen.routeName: (ctx) => PizzaEditScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
        },
      ),
    );
  }
}
