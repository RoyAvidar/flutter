import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/pizzas_provider.dart';
import '../providers/cart.dart';
import '../models/topping.dart';

class PizzaCircle extends StatefulWidget {
  @override
  _PizzaCircleState createState() => _PizzaCircleState();
}

class _PizzaCircleState extends State<PizzaCircle> {
  static final List<Topping> _toppList = [
    Toppings().peperoni,
    Toppings().bazil,
    Toppings().mushroom,
    Toppings().onion,
    Toppings().margherita,
    Toppings().bacon,
  ];
  Topping _dropdownValue = _toppList.first;
  Topping pickedValues;

  @override
  Widget build(BuildContext context) {
    final pizzaId = ModalRoute.of(context).settings.arguments as String;
    final cart = Provider.of<Cart>(context, listen: false);
    final loadedPizza =
        Provider.of<Pizzas>(context, listen: false).findById(pizzaId);
    Widget bigCircle = Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.orange,
        shape: BoxShape.circle,
      ),
    );
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Center(
            child: Stack(
              children: <Widget>[
                bigCircle,
                Positioned(
                  child: CircleButton(
                    onTap: () {
                      var oldToppings = loadedPizza.toppings;
                      if (loadedPizza.toppings.length <= 1) {
                        loadedPizza.toppings.add(pickedValues);
                        // final loadedPizzaPrice = int.parse(
                        //     loadedPizza.toppings.map((t) => t.price).join(","));
                        // final pickedValuesPrice = pickedValues.price;
                        // setState(() {
                        //   final totalPrice =
                        //       loadedPizzaPrice + pickedValuesPrice;
                        //   print(totalPrice);
                        //   return totalPrice;
                        // });
                      }
                      loadedPizza.toppings == oldToppings;
                    },
                    iconData: Icons.local_pizza,
                  ),
                  top: 120.0,
                  right: 10.0,
                ),
                Positioned(
                  child: CircleButton(
                    onTap: () {},
                    iconData: Icons.local_pizza,
                  ),
                  top: 120.0,
                  left: 10.0,
                ),
              ],
              overflow: Overflow.visible,
            ),
          ),
          SizedBox(height: 50),
          Text('Add a Topping'),
          DropdownButton<Topping>(
            value: _dropdownValue,
            icon: Icon(Icons.arrow_downward),
            iconSize: 20,
            elevation: 20,
            style: TextStyle(color: Theme.of(context).primaryColor),
            underline: Container(
              height: 2,
              color: Theme.of(context).accentColor,
            ),
            onChanged: (Topping value) {
              setState(() {
                _dropdownValue = value;
                pickedValues = _dropdownValue;
                print(pickedValues.name);
                print(pickedValues.price);
              });
            },
            items: [
              for (Topping i in _toppList)
                DropdownMenuItem(
                  value: i,
                  child: Text('${i.name}'),
                ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                elevation: 15,
                padding: EdgeInsets.all(10),
                onPressed: () {},
                child: Text(
                  'reset changes',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              RaisedButton(
                elevation: 15,
                padding: EdgeInsets.all(10),
                onPressed: () {
                  cart.addItem(
                    loadedPizza.id,
                    loadedPizza.price,
                    loadedPizza.title,
                    loadedPizza.toppings,
                  );
                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Added pizza to Cart!'),
                    duration: Duration(seconds: 1),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        cart.removeSingleItem(loadedPizza.id);
                      },
                    ),
                  ));
                },
                child: Text(
                  'add to cart',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData iconData;

  CircleButton({Key key, this.onTap, this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 50.0;

    return new InkResponse(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(
          iconData,
          color: Colors.black,
        ),
      ),
    );
  }
}
