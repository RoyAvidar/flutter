import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/address.dart';
import '../screens/edit_address_screen.dart';
import '../models/address.dart';

class AddressItemWidget extends StatefulWidget {
  final AddressItem addrs;
  final String addressId;
  // final String cityName;
  // final String streetName;
  // final int streetNumber;

  AddressItemWidget(this.addrs, this.addressId
      // this.addressId,
      // this.cityName,
      // this.streetName,
      // this.streetNumber,
      );

  @override
  _AddressItemWidgetState createState() => _AddressItemWidgetState();
}

class _AddressItemWidgetState extends State<AddressItemWidget> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Container(
              width: 100,
              child: Text('${widget.addrs.cityName}'),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
            subtitle: Text(widget.addrs.streetName),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            height: min(20.0 + 25, 100),
            child: Text('${widget.addrs.streetNumber}'),
            alignment: Alignment.topLeft,
          ),
          if (_expanded)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      EditAddressScreen.routeName,
                      arguments: widget.addressId,
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    return showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Are you sure?'),
                        content: Text(
                            'Do you want to remove the address from your Address List?'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('No'),
                            onPressed: () {
                              Navigator.of(ctx).pop(false);
                            },
                          ),
                          FlatButton(
                            child: Text('Yes'),
                            onPressed: () {
                              Provider.of<Address>(context, listen: false)
                                  .deleteAddress(widget.addressId);
                              Navigator.of(ctx).pop(true);
                            },
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}
