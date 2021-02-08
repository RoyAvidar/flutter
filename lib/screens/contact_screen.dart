import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class ContactScreen extends StatelessWidget {
  static const routeName = '/contact';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              'What is your Email?',
              style: TextStyle(
                color: Theme.of(context).backgroundColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              'rei@damrir.com',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 15,
                fontStyle: FontStyle.italic,
              ),
            ),
            Divider(),
            SizedBox(height: 20),
            Text(
              'How can I call you?',
              style: TextStyle(
                color: Theme.of(context).backgroundColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              '0506666886',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 15,
                fontStyle: FontStyle.italic,
              ),
            ),
            Divider(),
            SizedBox(height: 20),
            Text(
              'Can I work with you?',
              style: TextStyle(
                color: Theme.of(context).backgroundColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              '077-999-234-116',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 15,
                fontStyle: FontStyle.italic,
              ),
            ),
            Divider(),
            SizedBox(height: 20),
            Text(
              'I have an issue with an order..',
              style: TextStyle(
                color: Theme.of(context).backgroundColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              'https//:www.golikadik.com/shitinyour/mouth',
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 15,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
