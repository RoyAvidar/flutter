import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/pizza_overview_screen.dart';
import './screens/pizza_detail_screen.dart';
import './providers/pizzas_provider.dart';
import './providers/cart.dart';

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
        },
      ),
    );
  }
}
