import 'package:flutter/material.dart';

class PizzaCircle extends StatelessWidget {
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
          Container(),
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
