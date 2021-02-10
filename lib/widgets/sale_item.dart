import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/sale.dart';
import '../providers/cart.dart';

class SaleItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sale = Provider.of<Sale>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            //navigator to SalesDetailScreen
          },
          child: FadeInImage(
            placeholder: AssetImage('assets/images/pizza-placeholder.jpg'),
            image: NetworkImage(sale.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: () {
              cart.addSaleItem(
                sale.id,
                sale.price,
                sale.title,
                sale.pizzas,
              );
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Added pizza to Cart!'),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeSingleItem(sale.id);
                    },
                  ),
                ),
              );
            },
          ),
          backgroundColor: Colors.black54,
          title: Text(
            sale.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
