import 'package:flutter/material.dart';
import 'pizza.dart';
import '../models/topping.dart';

class Pizzas with ChangeNotifier {
  List<Pizza> _items = [
    Pizza(
      id: 'p1',
      title: 'Pepperoni Pizza',
      description:
          'Pepperoni, also known as pepperoni sausage, is an American variety of salami, usually made from cured pork and beef',
      price: 39.90,
      imageUrl:
          'https://townsquare.media/site/959/files/2020/08/GettyImages-1133727757.jpg',
      toppings: [Toppings().peperoni],
    ),
    Pizza(
      id: 'p2',
      title: 'Basil Pizza',
      description:
          'Italian immigrants in the windy city were searching for something similar to the Neapolitan pizza that they knew and loved.',
      price: 39.90,
      imageUrl:
          'https://cdn.loveandlemons.com/wp-content/uploads/2019/09/margherita-pizza-500x375.jpg',
      toppings: [Toppings().bazil],
    ),
    Pizza(
      id: 'p3',
      title: 'Mushroom Pizza',
      description:
          'This mushroom pizza is a white pizza that’s covered with mozzarella cheese, goat cheese, and fresh herbs. It’s perfection!',
      price: 39.90,
      imageUrl:
          'https://i0.wp.com/www.crowdedkitchen.com/wp-content/uploads/2020/07/mushroom-pizza-vegan.jpg',
      toppings: [Toppings().mushroom],
    ),
    Pizza(
      id: 'p4',
      title: 'Onion Pizza',
      description:
          'Simple Caramelized Onion White Pizza should be what its name implies – just pizza dough and mouthwatering caramelized onions. OK, a bit of cheese too. But nothing else. ',
      price: 39.90,
      imageUrl:
          'https://realitybakes.com/wp-content/uploads/2020/01/Roasted-Red-Pepper-and-Red-Onion-Pizza-8.jpg',
      toppings: [Toppings().onion],
    ),
    Pizza(
      id: 'p5',
      title: 'Pizza Margherita',
      description:
          'izza Margherita is a typical Neapolitan pizza, made with San Marzano tomatoes, mozzarella cheese, fresh basil, salt and extra-virgin olive oil.',
      price: 29.90,
      imageUrl: 'https://i.ytimg.com/vi/xKDnD8sJsuY/maxresdefault.jpg',
      toppings: [Toppings().margherita],
    )
  ];

  List<Pizza> get items {
    return [..._items];
  }

  Pizza findById(String id) {
    return _items.firstWhere((pizz) => pizz.id == id);
  }

  List<Pizza> get favoriteItems {
    return _items.where((pizzaItem) => pizzaItem.isFavorite).toList();
  }

  void addPizza(Pizza pizza) {
    final newPizza = Pizza(
      title: pizza.title,
      description: pizza.description,
      price: pizza.price,
      imageUrl: pizza.imageUrl,
      toppings: pizza.toppings,
      id: DateTime.now().toString(),
    );
    _items.add(newPizza);
    notifyListeners();
  }

  void updatePizza(String id, Pizza newPizza) {
    final pizzIndex = _items.indexWhere((pizz) => pizz.id == id);
    if (pizzIndex >= 0) {
      _items[pizzIndex] = newPizza;
      notifyListeners();
    } else {
      print('...');
    }
  }
}
