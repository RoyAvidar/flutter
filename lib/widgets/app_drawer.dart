import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/orders_screen.dart';
import '../screens/admin_pizza_screen.dart';

import '../providers/auth.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  Future<bool> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataAdmin = prefs.getBool('isAdmin');
    return userDataAdmin;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          FutureBuilder(
            future: getUserData(),
            builder: (ctx, snapshot) {
              if (snapshot.data == true) {
                return ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Manage Pizzas'),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(AdminPizzaScreen.routeName);
                  },
                );
              } else {
                return Divider();
              }
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info_outline_rounded),
            title: Text('Personal Information'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/personalInfo');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
