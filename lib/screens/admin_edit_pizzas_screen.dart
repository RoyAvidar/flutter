import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/pizza.dart';
import '../providers/pizzas_provider.dart';
import '../models/topping.dart';

class AdminEditPizzaScreen extends StatefulWidget {
  static const routeName = '/admin-edit-pizza';
  @override
  _AdminEditPizzaScreenState createState() => _AdminEditPizzaScreenState();
}

class _AdminEditPizzaScreenState extends State<AdminEditPizzaScreen> {
  final _priceFocusNode = FocusNode();
  final _imageUrlController = TextEditingController(text: '');
  final _imageUrlFocusNode = FocusNode();
  var _editedPizza = Pizza(
    id: null,
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
    toppings: null,
  );
  List<Topping> editedToppings = [];
  var _isInit = true;
  var _isLoading = false;
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
    'toppings': '',
  };

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final pizzaId = ModalRoute.of(context).settings.arguments as String;
      if (pizzaId != null) {
        _editedPizza =
            Provider.of<Pizzas>(context, listen: false).findById(pizzaId);
        _initValues = {
          'title': _editedPizza.title,
          'description': _editedPizza.description,
          'price': _editedPizza.price.toString(),
          'imageUrl': '',
          //'toppings': _editedPizza.toppings.toString(),
        };
        _imageUrlController.text = _editedPizza.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid =
        _formKey.currentState.validate(); //triggers all the validators
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedPizza.id != null) {
      await Provider.of<Pizzas>(context, listen: false)
          .updatePizza(_editedPizza.id, _editedPizza);
    } else {
      try {
        await Provider.of<Pizzas>(context, listen: false)
            .addPizza(_editedPizza);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occurred!'),
            content: Text('Something went wrong.'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Okay'),
              )
            ],
          ),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  final _formKey = GlobalKey<FormState>();
  static final List<Topping> _nameList = [
    Toppings().peperoni,
    Toppings().bazil,
    Toppings().mushroom,
    Toppings().onion,
    Toppings().margherita,
    Toppings().bacon,
  ];
  Topping _dropdownValue = _nameList.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Pizza'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['title'],
                      decoration: InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedPizza = Pizza(
                          title: value,
                          description: _editedPizza.description,
                          price: _editedPizza.price,
                          imageUrl: _editedPizza.imageUrl,
                          toppings: _editedPizza.toppings,
                          id: _editedPizza.id,
                          isFavorite: _editedPizza.isFavorite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['price'],
                      decoration: InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a price.';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        if (double.parse(value) <= 10) {
                          return 'Minimum price should be greater than ten.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedPizza = Pizza(
                          title: _editedPizza.title,
                          description: _editedPizza.description,
                          price: double.parse(value),
                          imageUrl: _editedPizza.imageUrl,
                          toppings: _editedPizza.toppings,
                          id: _editedPizza.id,
                          isFavorite: _editedPizza.isFavorite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a description.';
                        }
                        if (value.length < 10) {
                          return 'Description should be at least 10 charecters long';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedPizza = Pizza(
                          title: _editedPizza.title,
                          description: value,
                          price: _editedPizza.price,
                          imageUrl: _editedPizza.imageUrl,
                          toppings: _editedPizza.toppings,
                          id: _editedPizza.id,
                          isFavorite: _editedPizza.isFavorite,
                        );
                      },
                    ),
                    DropdownButtonFormField<Topping>(
                      decoration: InputDecoration(labelText: 'Toppings'),
                      value: _dropdownValue,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 20,
                      elevation: 15,
                      style: TextStyle(color: Colors.deepOrange),
                      onChanged: (Topping newValue) {
                        setState(() {
                          _dropdownValue = newValue;
                        });
                      },
                      items: [
                        for (Topping i in _nameList)
                          DropdownMenuItem(
                            value: i,
                            child: Text('${i.name}'),
                          ),
                      ],
                      validator: (value) {
                        if (value == null) {
                          return 'Please choose a topping.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedPizza = Pizza(
                          title: _editedPizza.title,
                          description: _editedPizza.description,
                          price: _editedPizza.price,
                          imageUrl: _editedPizza.imageUrl,
                          toppings: [value],
                          id: _editedPizza.id,
                          isFavorite: _editedPizza.isFavorite,
                        );
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(top: 8, right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Text('Enter a URL')
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            //initialValue: _initValues['imageUrl'],
                            decoration: InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onEditingComplete: () {
                              setState(() {});
                            },
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter an image.';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'Please enter a valid URL.';
                              }
                              if (!value.endsWith('.png') &&
                                  !value.endsWith('.jpg') &&
                                  !value.endsWith('.jpeg')) {
                                return 'Please enter a valid image Url.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedPizza = Pizza(
                                title: _editedPizza.title,
                                description: _editedPizza.description,
                                price: _editedPizza.price,
                                imageUrl: value,
                                toppings: _editedPizza.toppings,
                                id: _editedPizza.id,
                                isFavorite: _editedPizza.isFavorite,
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
