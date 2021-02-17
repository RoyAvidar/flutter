import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../providers/pizzas_provider.dart';
import '../providers/pizza.dart';
import '../providers/auth.dart';

class AdminSaleScreen extends StatefulWidget {
  static const routeName = '/admin-sale-form';
  @override
  _AdminSaleScreenState createState() => _AdminSaleScreenState();
}

class _AdminSaleScreenState extends State<AdminSaleScreen> {
  final _priceController = TextEditingController(text: '');

  Future<void> _saveForm() async {
    final auth = Provider.of<Auth>(context, listen: false);
    final authToken = auth.token;
    final isValid =
        _salesFormKey.currentState.validate(); //triggers all the validators
    if (!isValid) {
      return;
    }
    isPizzaSelected.forEach((pizza, value) async {
      if (value) {
        var url =
            'https://flutter-pizza-1c1e7-default-rtdb.firebaseio.com/pizza/${pizza.id}.json?auth=$authToken';
        try {
          await http.put(
            url,
            body: json.encode({
              'isOnSale': true,
              'id': pizza.id,
              'title': pizza.title,
              'description': pizza.description,
              'price': pizza.price,
              'salePrice': _priceController.text,
              'imageUrl': pizza.imageUrl,
              'toppings': pizza.toppings
                  .map((t) => {'name': t.name, 'price': t.price})
                  .toList(),
            }),
          );
          Navigator.of(context).pop();
        } catch (error) {
          print(error);
        }
      }
    });
  }

  List<Widget> pizzaTileList(List<Pizza> pizzaList) {
    final List<Widget> checkBoxList = [];
    for (var pizza in pizzaList) {
      isPizzaSelected.putIfAbsent(pizza, () => false);
      checkBoxList.add(
        CheckboxListTile(
          title: Text(pizza.title),
          controlAffinity: ListTileControlAffinity.leading,
          value: isPizzaSelected[pizza],
          onChanged: (isSelected) {
            setState(() {
              isPizzaSelected[pizza] = isSelected;
            });
          },
        ),
      );
    }
    return checkBoxList;
  }

  final _salesFormKey = GlobalKey<FormState>();
  var _isLoading = false;
  Map<Pizza, bool> isPizzaSelected = {};

  @override
  Widget build(BuildContext context) {
    final pizzaList = Provider.of<Pizzas>(context, listen: false).items;

    return Scaffold(
        appBar: AppBar(
          title: Text('Add A Sale'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _saveForm,
            )
          ],
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _salesFormKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'title',
                          border: OutlineInputBorder(),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide a value';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'description',
                          border: OutlineInputBorder(),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide a value';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _priceController,
                        decoration: InputDecoration(
                          labelText: 'Price',
                          border: OutlineInputBorder(),
                        ),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide a value';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 50),
                      Column(
                        children: pizzaTileList(pizzaList),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
