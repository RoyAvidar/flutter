import 'package:flutter/material.dart';

class PizzaCircle extends StatefulWidget {
  @override
  _PizzaCircleState createState() => _PizzaCircleState();
}

class _PizzaCircleState extends State<PizzaCircle> {
  String dropDownValue = 'one';

  @override
  Widget build(BuildContext context) {
    Widget bigCircle = Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.orange,
        shape: BoxShape.circle,
      ),
    );
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Center(
            child: Stack(
              children: <Widget>[
                bigCircle,
                Positioned(
                  child: CircleButton(
                    onTap: () => print("Coolio"),
                    iconData: Icons.local_pizza,
                  ),
                  top: 120.0,
                  right: 10.0,
                ),
                Positioned(
                  child: CircleButton(
                    onTap: () => print("Cool"),
                    iconData: Icons.local_pizza,
                  ),
                  top: 120.0,
                  left: 10.0,
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          Text('Add a Topping'),
          DropdownButton<String>(
            value: dropDownValue,
            icon: Icon(Icons.arrow_downward),
            iconSize: 20,
            elevation: 20,
            style: TextStyle(color: Theme.of(context).primaryColor),
            underline: Container(
              height: 2,
              color: Theme.of(context).accentColor,
            ),
            onChanged: (String value) {
              setState(() {
                dropDownValue = value;
              });
            },
            items: <String>['one', 'two', 'three', 'four']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                elevation: 15,
                padding: EdgeInsets.all(10),
                onPressed: () {},
                child: Text(
                  'reset changes',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              RaisedButton(
                elevation: 15,
                padding: EdgeInsets.all(10),
                onPressed: () {},
                child: Text(
                  'add to cart',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData iconData;

  CircleButton({Key key, this.onTap, this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 50.0;

    return new InkResponse(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(
          iconData,
          color: Colors.black,
        ),
      ),
    );
  }
}
