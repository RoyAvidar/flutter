import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './cart_screen.dart';
import '../widgets/pizzas_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../providers/pizzas_provider.dart';

import '../widgets/app_drawer.dart';

enum FilterOptions {
  Sale,
  Favorites,
  All,
}

class PizzaOverviewScreen extends StatefulWidget {
  @override
  _PizzaOverviewScreenState createState() => _PizzaOverviewScreenState();
}

class _PizzaOverviewScreenState extends State<PizzaOverviewScreen> {
  bool _showOnlyFavorites = false;
  bool _showOnlySales = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    //Provider.of<Pizzas>(context).fetchAndSetPizzas(); Won't work
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Pizzas>(context).fetchAndSetPizzas().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pizza Time!'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else if (selectedValue == FilterOptions.Sale) {
                  _showOnlySales = true;
                } else {
                  _showOnlyFavorites = false;
                  _showOnlySales = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Show Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show Sales'),
                value: FilterOptions.Sale,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
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
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : PizzasGrid(_showOnlyFavorites, _showOnlySales),
    );
  }
}
