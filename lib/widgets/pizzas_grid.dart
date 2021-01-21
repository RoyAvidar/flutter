import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './pizza_item.dart';
import '../providers/pizzas_provider.dart';

class PizzasGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pizzasData = Provider.of<Pizzas>(context);
    final pizzas = pizzasData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: pizzas.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider(
        create: (c) => pizzas[i],
        child: PizzaItem(
            // pizzas[i].id,
            // pizzas[i].title,
            // pizzas[i].imageUrl,
            ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
