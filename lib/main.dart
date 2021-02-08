import 'package:flutter/material.dart';
import 'package:flutter_pizza/providers/address.dart';
import 'package:provider/provider.dart';

import './screens/pizza_edit_screen.dart';
import './screens/splash_screen.dart';
import './screens/orders_screen.dart';
import './screens/cart_screen.dart';
import './screens/pizza_overview_screen.dart';
import './screens/pizza_detail_screen.dart';
import './screens/admin_pizza_screen.dart';
import './screens/admin_edit_pizzas_screen.dart';
import './screens/auth_screen.dart';
import './screens/personal_info_screen.dart';
import './screens/address_screen.dart';
import './screens/edit_address_screen.dart';
import './screens/contact_screen.dart';
import 'screens/about_us_screen.dart';
import './providers/pizzas_provider.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Pizzas>(
          update: (ctx, auth, previousPizzas) => Pizzas(
            auth.token,
            auth.userId,
            previousPizzas == null ? [] : previousPizzas.items,
          ),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, auth, previousOrders) => Orders(
            auth.token,
            auth.userId,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Address>(
          update: (ctx, auth, previousAddress) => Address(
            auth.token,
            auth.userId,
            previousAddress == null ? [] : previousAddress.addressList,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, authData, _) => MaterialApp(
          title: 'Pizza Time',
          theme: ThemeData(
            primaryColor: Colors.yellow[800],
            accentColor: Colors.red,
          ),
          home: authData.isAuth
              ? PizzaOverviewScreen()
              : FutureBuilder(
                  future: authData.tryAutoLogin(),
                  builder: (ctx, authResult) =>
                      authResult.connectionState == ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            PizzaDetailScreen.routeName: (ctx) => PizzaDetailScreen(),
            PizzaEditScreen.routeName: (ctx) => PizzaEditScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            AdminPizzaScreen.routeName: (ctx) => AdminPizzaScreen(),
            AdminEditPizzaScreen.routeName: (ctx) => AdminEditPizzaScreen(),
            PersonalInfoScreen.routeName: (ctx) => PersonalInfoScreen(),
            AddressScreen.routeName: (ctx) => AddressScreen(),
            EditAddressScreen.routeName: (ctx) => EditAddressScreen(),
            ContactScreen.routeName: (ctx) => ContactScreen(),
            AboutUsScreen.routName: (ctx) => AboutUsScreen(),
          },
        ),
      ),
    );
  }
}
