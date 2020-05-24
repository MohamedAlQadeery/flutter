import 'package:flutter/material.dart';

class CartProducts extends StatefulWidget {
  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  var productOnThecart = [
    {
      "name": "Blazer",
      "picture": "images/products/blazer1.jpeg",
      "price": 85,
      "size": "M",
      "color": "red",
      "quantity": 1
    },
    {
      "name": "Dress",
      "picture": "images/products/dress1.jpeg",
      "price": 50,
      "size": "s",
      "color": "white",
      "quantity": 2
    },
  ];
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: 2,
      itemBuilder: (context, int index) {
        return SingleCartProduct(
          cartName: productOnThecart[index]["name"],
          cartPicture: productOnThecart[index]["picture"],
          cartPrice: productOnThecart[index]["price"],
          cartSize: productOnThecart[index]["size"],
          cartColor: productOnThecart[index]["color"],
          cartQuantity: productOnThecart[index]["quantity"],
        );
      },
    );
  }
}

class SingleCartProduct extends StatelessWidget {
  final cartName;
  final cartPicture;
  final cartPrice;
  final cartSize;
  final cartColor;
  final cartQuantity;
  SingleCartProduct(
      {this.cartName,
      this.cartPicture,
      this.cartPrice,
      this.cartSize,
      this.cartColor,
      this.cartQuantity});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          //** image product */
          Image.asset(
            cartPicture,
            width: 80.0,
            height: 80.0,
          ),
          //** info product  */
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //** product name */
              Text(cartName),

              //** start size , color   */
              new Row(
                children: <Widget>[
                  ///** product size */
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
                    child: Text("Size"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(.0),
                    child: Text(
                      cartSize,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),

                  ///** cart color  */
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                    child: Text("Color"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      cartColor,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
              //** end   size , color ,  */

              //** product price */
              Text(
                "\$$cartPrice",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),

              ///** end product price  */
            ],
          ),

          ///** product Quantity */
          Container(
            padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
            child: Column(
              children: <Widget>[
                new IconButton(
                    icon: Icon(Icons.arrow_drop_up), onPressed: () {}),
                new Text("${cartQuantity}"),
                new IconButton(
                    icon: Icon(Icons.arrow_drop_down), onPressed: () {}),
              ],
            ),
          )
        ],
      ),
    );
  }
}
