import 'package:flutter_app1/components/CartProduct.dart';
import 'package:flutter/material.dart';

///** by Abdalmohsen */
class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        backgroundColor: Colors.red,
        elevation: 0.1,
        centerTitle: false,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
//** body  */
      body: new CartProducts(),
      //***  */

/** footer  */
      //** bottomNavigationBar  */
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: new Text("Total:"),
                subtitle: new Text("\$230"),
              ),
            ),
            Expanded(
              child: new MaterialButton(
                onPressed: () {},
                child: Text(
                  "Chech out",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
