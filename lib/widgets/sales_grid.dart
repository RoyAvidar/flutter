import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/sales.dart';
import '../widgets/sale_item.dart';

class SalesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final salesData = Provider.of<Sales>(context);
    final sales = salesData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: sales.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: sales[i],
        child: SaleItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
