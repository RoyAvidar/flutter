import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/pizzas_provider.dart';
import '../widgets/admin_pizza_item.dart';
import '../widgets/app_drawer.dart';
import '../screens/admin_edit_pizzas_screen.dart';

class AdminPizzaScreen extends StatelessWidget {
  static const routeName = '/admin-pizzas';

  @override
  Widget build(BuildContext context) {
    final pizzasData = Provider.of<Pizzas>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Pizzas'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AdminEditPizzaScreen.routeName);
              })
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: pizzasData.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              AdminPizzaItem(
                pizzasData.items[i].title,
                pizzasData.items[i].imageUrl,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
