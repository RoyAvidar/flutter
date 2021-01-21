import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/pizzas_provider.dart';

class PizzaDetailScreen extends StatelessWidget {
  static const routeName = '/pizza-detail';

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
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.network(loadedPizza.imageUrl),
              Text(loadedPizza.description),
              Text(loadedPizza.price.toString()),
              Row(
                children: <Widget>[
                  RaisedButton.icon(
                    onPressed: null,
                    icon: Icon(Icons.add),
                    label: Text('add to cart'),
                  ),
                  SizedBox(
                    width: 35,
                  ),
                  RaisedButton(
                    onPressed: () {},
                    child: Text('Edit Pizza'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
