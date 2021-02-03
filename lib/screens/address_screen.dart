import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/address.dart';
import '../widgets/app_drawer.dart';
import '../widgets/address_item.dart';
import '../screens/edit_address_screen.dart';

class AddressScreen extends StatelessWidget {
  static const routeName = '/address';
  @override
  Widget build(BuildContext context) {
    final address = Provider.of<Address>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Address'),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Add Address',
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                    icon: Icon(Icons.add_box_outlined),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(EditAddressScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          // here are going to be all the userAddress in a list (addressItem)
          Expanded(
            child: ListView.builder(
              itemCount: address.addressCount,
              itemBuilder: (ctx, i) => AddressItemWidget(
                address.addressMap.values.toList()[i].addressId,
                address.addressMap.values.toList()[i].cityName,
                address.addressMap.values.toList()[i].streetName,
                address.addressMap.values.toList()[i].streetNumber,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
