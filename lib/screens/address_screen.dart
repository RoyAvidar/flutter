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
    bool isPicking = false;
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
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).accentColor,
                    ),
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
          SizedBox(
            height: 10,
          ),
          FutureBuilder(
            future: Provider.of<Address>(context, listen: false).fetchAddress(),
            builder: (ctx, snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                if (snapShot.error != null) {
                  print(snapShot.error);
                  return Center(
                    child: Text('An Error has occured!'),
                  );
                } else {
                  return Consumer<Address>(
                    builder: (ctx, addressData, child) => ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: addressData.addressCount,
                      itemBuilder: (ctx, i) => AddressItemWidget(
                        addressData.addressList[i],
                        addressData.addressList[i].addressId,
                        isPicking,
                      ),
                    ),
                  );
                }
              }
            },
          )
        ],
      ),
    );
  }
}
