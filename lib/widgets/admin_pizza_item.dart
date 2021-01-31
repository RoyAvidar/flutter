import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/admin_edit_pizzas_screen.dart';
import '../providers/pizzas_provider.dart';

class AdminPizzaItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  AdminPizzaItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AdminEditPizzaScreen.routeName, arguments: id);
                },
                color: Theme.of(context).primaryColor,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  Provider.of<Pizzas>(context, listen: false).deletePizza(id);
                },
                color: Theme.of(context).errorColor,
              ),
            ],
          ),
        ));
  }
}
