import 'package:flutter/material.dart';
import 'package:flutter_app1/HomePage.dart';


class ProductDetails extends StatefulWidget {
  final productDetailName;
  final productDetailPicture;
  final productDetailOldPrice;
  final productDetailNewPrice;

  ProductDetails(
      {this.productDetailName,
      this.productDetailNewPrice,
      this.productDetailOldPrice,
      this.productDetailPicture});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // start app bar
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => new HomePage()));
          },
          child: Text("Fashapp"),
        ),
        backgroundColor: Colors.red,
        elevation: 0.1,
        centerTitle: true,
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

      /// body
      body: new ListView(
        children: <Widget>[
          new Container(
            height: 260,
            padding: EdgeInsets.all(0.0),
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.asset(widget.productDetailPicture),
              ),
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(
                    widget.productDetailName,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "\$${widget.productDetailOldPrice}",
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "\$${widget.productDetailNewPrice}",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

          //*********************First Row of buttons  */
          Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return new AlertDialog(
                            title: new Text("Size"),
                            content: new Text("choose the size"),
                            actions: <Widget>[
                              new MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: new Text(
                                  "Close",
                                  style: TextStyle(color: Colors.red),
                                ),
                              )
                            ],
                          );
                        });
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  //*** size button  */
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("Size"),
                      ),
                      Expanded(
                        child: Icon(Icons.arrow_drop_down),
                      )
                    ],
                  ),
                ),
              ),

              /** Color button  */
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Color"),
                            content: new Text("Choose the Color"),
                            actions: <Widget>[
                              new MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: new Text(
                                  "close",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,

                  /** Color button  */
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("Color"),
                      ),
                      Expanded(
                        child: Icon(Icons.arrow_drop_down),
                      )
                    ],
                  ),
                ),
              ),
              //** Quantity boutton  */
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: new Text("Quantity"),
                            content: Text("Choose the Quantity"),
                            actions: <Widget>[
                              new MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Close",
                                    style: TextStyle(color: Colors.red)),
                              )
                            ],
                          );
                        });
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,

                  //** Quantity boutton  */
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("Qty"),
                      ),
                      Expanded(
                        child: Icon(Icons.arrow_drop_down),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          //*********  the secound button            */
          //** by button  */
          Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                    onPressed: () {},
                    color: Colors.red,
                    textColor: Colors.white,
                    elevation: 0.2,
                    child: Text("By Now")),
              ),
              new IconButton(
                icon: Icon(Icons.add_shopping_cart),
                color: Colors.red,
                onPressed: () {},
              ),
              new IconButton(
                icon: Icon(Icons.favorite_border),
                color: Colors.red,
                onPressed: () {},
              ),
            ],
          ),
          Divider(),

          ///** list Tile  */
          new ListTile(
            title: Text("Product detailse"),
            subtitle: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged"),
          ),
          Divider(),
//** produvt name */
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text(
                  "Product name",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(widget.productDetailName),
              ),
            ],
          ),
//** product brand */
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text(
                  "Product brand",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              // remember to create product brand
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text("Brand X"),
              ),
            ],
          ),
//** product condition*/
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: Text(
                  "Product Condition ",
                  style: TextStyle(color: Colors.grey),
                ),
              ),

              // remember to create product condition
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text("NEW"),
              ),
            ],
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Similar products"),
          ),

          /// simeler product section
          Container(
            height: 360.0,
            child: SimilerProduct(),
          )
        ],
      ),
    );
  }
}

///**similarProduct */
class SimilerProduct extends StatefulWidget {
  @override
  _SimilerProductState createState() => _SimilerProductState();
}

class _SimilerProductState extends State<SimilerProduct> {
  var productList = [
    {
      "name": "Hills",
      "picture": "images/products/hills1.jpeg",
      "oldPrice": 110,
      "price": 70,
    },
    {
      "name": "Pants",
      "picture": "images/products/pants1.jpg",
      "oldPrice": 90,
      "price": 40,
    },
    {
      "name": "Shoe",
      "picture": "images/products/shoe1.jpeg",
      "oldPrice": 140,
      "price": 90,
    },
    {
      "name": "skt",
      "picture": "images/products/skt1.jpeg",
      "oldPrice": 120,
      "price": 80,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: productList.length,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return SimilarSingleProduct(
          productName: productList[index]['name'],
          productPicture: productList[index]['picture'],
          oldPrice: productList[index]['oldPrice'],
          prodPrice: productList[index]['price'],
        );
      },
    );
  }
}

//** single product */
class SimilarSingleProduct extends StatelessWidget {
  final productName;
  final productPicture;
  final oldPrice;
  final prodPrice;

  SimilarSingleProduct({
    this.productName,
    this.productPicture,
    this.oldPrice,
    this.prodPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Hero(
      tag: productName,
      child: Material(
        child: InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              // passing the valuse of the product to productDetails Page
              builder: (context) => new ProductDetails(
                    productDetailName: productName,
                    productDetailPicture: productPicture,
                    productDetailNewPrice: prodPrice,
                    productDetailOldPrice: oldPrice,
                  ))),
          child: GridTile(
            footer: Container(
                color: Colors.white70,
                child: new Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        productName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                    ),
                    new Text(
                      "\$${prodPrice}",
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    )
                  ],
                )),
            child: Image.asset(
              productPicture,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ));
  }
}
