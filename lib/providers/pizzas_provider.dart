import 'package:flutter/material.dart';
import 'pizza.dart';
import '../models/topping.dart';
import '../models/http_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Pizzas with ChangeNotifier {
  List<Pizza> _items = [
    // Pizza(
    //   id: 'p1',
    //   title: 'Pepperoni Pizza',
    //   description:
    //       'Pepperoni, also known as pepperoni sausage, is an American variety of salami, usually made from cured pork and beef',
    //   price: 39.90,
    //   imageUrl:
    //       'https://townsquare.media/site/959/files/2020/08/GettyImages-1133727757.jpg',
    //   toppings: [Toppings().peperoni],
    // ),
    // Pizza(
    //   id: 'p2',
    //   title: 'Basil Pizza',
    //   description:
    //       'Italian immigrants in the windy city were searching for something similar to the Neapolitan pizza that they knew and loved.',
    //   price: 39.90,
    //   imageUrl:
    //       'https://cdn.loveandlemons.com/wp-content/uploads/2019/09/margherita-pizza-500x375.jpg',
    //   toppings: [Toppings().bazil],
    // ),
    // Pizza(
    //   id: 'p3',
    //   title: 'Mushroom Pizza',
    //   description:
    //       'This mushroom pizza is a white pizza that’s covered with mozzarella cheese, goat cheese, and fresh herbs. It’s perfection!',
    //   price: 39.90,
    //   imageUrl:
    //       'https://i0.wp.com/www.crowdedkitchen.com/wp-content/uploads/2020/07/mushroom-pizza-vegan.jpg',
    //   toppings: [Toppings().mushroom],
    // ),
    // Pizza(
    //   id: 'p4',
    //   title: 'Onion Pizza',
    //   description:
    //       'Simple Caramelized Onion White Pizza should be what its name implies – just pizza dough and mouthwatering caramelized onions. OK, a bit of cheese too. But nothing else. ',
    //   price: 39.90,
    //   imageUrl:
    //       'https://realitybakes.com/wp-content/uploads/2020/01/Roasted-Red-Pepper-and-Red-Onion-Pizza-8.jpg',
    //   toppings: [Toppings().onion],
    // ),
    // Pizza(
    //   id: 'p5',
    //   title: 'Pizza Margherita',
    //   description:
    //       'Pizza Margherita is a typical Neapolitan pizza, made with San Marzano tomatoes, mozzarella cheese, fresh basil, salt and extra-virgin olive oil.',
    //   price: 29.90,
    //   imageUrl: 'https://i.ytimg.com/vi/xKDnD8sJsuY/maxresdefault.jpg',
    //   toppings: [Toppings().margherita],
    // )
  ];

  final String authToken;
  final String userId;

  Pizzas(this.authToken, this.userId, this._items);

  List<Pizza> get items {
    return [..._items];
  }

  Pizza findById(String id) {
    return _items.firstWhere((pizz) => pizz.id == id);
  }

  List<Pizza> get favoriteItems {
    return _items.where((pizzaItem) => pizzaItem.isFavorite).toList();
  }

  List<Pizza> get saleItems {
    return _items.where((pizzaItem) => pizzaItem.isOnSale).toList();
  }

  Future<void> fetchAndSetPizzas() async {
    var url =
        'https://flutter-pizza-1c1e7-default-rtdb.firebaseio.com/pizza.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      url =
          'https://flutter-pizza-1c1e7-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      final List<Pizza> loadedPizzas = [];
      extractedData.forEach((pizzId, pizzData) {
        loadedPizzas.add(Pizza(
          id: pizzId,
          title: pizzData['title'],
          description: pizzData['description'],
          price: pizzData['price'],
          isFavorite:
              favoriteData == null ? false : favoriteData[pizzId] ?? false,
          isOnSale: pizzData['isOnSale'] != null ? pizzData['isOnSale'] : false,
          salePrice: pizzData['salePrice'] != null
              ? double.parse(pizzData['salePrice'])
              : null,
          imageUrl: pizzData['imageUrl'],
          toppings: ((pizzData['toppings']) as List<dynamic>)
              .map((t) => Topping(t['name'], t['price']))
              .toList(),
        ));
      });
      _items = loadedPizzas;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addPizza(Pizza pizza) async {
    final url =
        'https://flutter-pizza-1c1e7-default-rtdb.firebaseio.com/pizza.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': pizza.title,
          'description': pizza.description,
          'price': pizza.price,
          'imageUrl': pizza.imageUrl,
          'toppings': pizza.toppings
              .map((t) => {'name': t.name, 'price': t.price})
              .toList()
        }),
      );
      final newPizza = Pizza(
        title: pizza.title,
        description: pizza.description,
        price: pizza.price,
        imageUrl: pizza.imageUrl,
        toppings: pizza.toppings,
        id: json.decode(response.body)['name'],
      );
      _items.add(newPizza);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updatePizza(String id, Pizza newPizza) async {
    final pizzIndex = _items.indexWhere((pizz) => pizz.id == id);
    if (pizzIndex >= 0) {
      final url =
          'https://flutter-pizza-1c1e7-default-rtdb.firebaseio.com/pizza/$id.json?auth=$authToken';
      await http.patch(url,
          body: json.encode({
            'title': newPizza.title,
            'description': newPizza.description,
            'imageUrl': newPizza.imageUrl,
            'price': newPizza.price,
            'toppings': newPizza.toppings
                .map((t) => {'name': t.name, 'price': t.price})
                .toList(),
          }));
      _items[pizzIndex] = newPizza;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deletePizza(String id) async {
    final url =
        'https://flutter-pizza-1c1e7-default-rtdb.firebaseio.com/pizza/$id.json?auth=$authToken';
    final existingPizzaIndex = _items.indexWhere((pizza) => pizza.id == id);
    var existingPizza = _items[existingPizzaIndex];
    _items.removeAt(existingPizzaIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingPizzaIndex, existingPizza);
      notifyListeners();
      throw HttpException('Could not delete pizza.');
    }
    existingPizza = null;
  }

  Future<void> addTopping(
      String pizzaId, Topping newTopping, Pizza oldPizza) async {
    final pizzIndex = _items.indexWhere((pizz) => pizz.id == pizzaId);
    if (pizzIndex >= 0) {
      final List<Topping> newTopp = [];
      newTopp.add(newTopping);
      final url =
          'https://flutter-pizza-1c1e7-default-rtdb.firebaseio.com/pizza/$pizzaId.json?auth=$authToken';
      await http.patch(url,
          body: json.encode({
            'title': oldPizza.title,
            'description': oldPizza.description,
            'imageUrl': oldPizza.imageUrl,
            'price': oldPizza.price,
            'toppings':
                newTopp.map((t) => {'name': t.name, 'price': t.price}).toList(),
          }));
      _items[pizzIndex] = oldPizza;
      notifyListeners();
    } else {
      print('error. something went wrong with adding a topping');
    }
  }
}
