import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class AboutUsScreen extends StatelessWidget {
  static const routName = '/aboutUs';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About our Pizza'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text('works'),
      ),
    );
  }
}
