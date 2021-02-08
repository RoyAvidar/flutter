import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class PersonalInfoScreen extends StatelessWidget {
  static const routeName = '/personalInfo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Information'),
      ),
      drawer: AppDrawer(),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(10)),
            ListTile(
              leading: Icon(Icons.arrow_forward_ios_outlined),
              title: Text('My adresses'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/address');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.arrow_forward_ios_outlined),
              title: Text('Payment methods'),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.arrow_forward_ios_outlined),
              title: Text('About us'),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.arrow_forward_ios_outlined),
              title: Text('Contact'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/contact');
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
