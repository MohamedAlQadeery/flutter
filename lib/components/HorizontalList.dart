import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            imageLocatioin: 'images/cats/dress.png',
            imageCaption: 'Dress',
          ),
          Category(
            imageLocatioin: 'images/cats/formal.png',
            imageCaption: 'Formal',
          ),
          Category(
            imageLocatioin: 'images/cats/informal.png',
            imageCaption: 'Informal',
          ),
          Category(
            imageLocatioin: 'images/cats/tshirt.png',
            imageCaption: 'Tshert',
          ),
          Category(
            imageLocatioin: 'images/cats/jeans.png',
            imageCaption: 'Jeans',
          ),
          Category(
            imageLocatioin: 'images/cats/shoe.png',
            imageCaption: 'Shoe',
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String imageLocatioin;
  final String imageCaption;

  Category({this.imageLocatioin, this.imageCaption});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {},
          child: Container(
            width: 100.0,
            child: ListTile(
                title: Image.asset(imageLocatioin, width: 80.0, height: 50.0),
                subtitle: Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    imageCaption,
                    style: new TextStyle(fontSize: 12.0),
                  ),
                )),
          ),
        ));
  }
}
