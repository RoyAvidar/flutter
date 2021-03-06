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
    final scaffold = Scaffold.of(context);
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
                  try {
                    return showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Are you sure?'),
                        content: Text(
                            'Do you want to remove this pizza from the list?'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('No'),
                            onPressed: () {
                              Navigator.of(ctx).pop(false);
                            },
                          ),
                          FlatButton(
                            child: Text('Yes'),
                            onPressed: () async {
                              await Provider.of<Pizzas>(context, listen: false)
                                  .deletePizza(id);
                              Navigator.of(ctx).pop(true);
                            },
                          )
                        ],
                      ),
                    );
                  } catch (error) {
                    scaffold.showSnackBar(
                      SnackBar(
                        content: Text('Deleting falied'),
                      ),
                    );
                  }
                },
                color: Theme.of(context).errorColor,
              ),
            ],
          ),
        ));
  }
}
