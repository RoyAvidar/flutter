import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/address.dart';
import '../widgets/address_item.dart';

class PickAddressScreen extends StatelessWidget {
  static const routeName = '/pick_address';
  @override
  Widget build(BuildContext context) {
    bool isPicking = false;
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick an Address'),
      ),
      body: FutureBuilder(
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
      ),
    );
  }
}
