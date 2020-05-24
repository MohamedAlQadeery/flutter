import 'package:flutter_app1/pages/productDetailse.dart';
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var productList = [
    {
      "name": "Blazer",
      "picture": "images/products/blazer1.jpeg",
      "oldPrice": 120,
      "price": 85,
    },
    {
      "name": "Dress",
      "picture": "images/products/dress1.jpeg",
      "oldPrice": 100,
      "price": 50,
    },
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
        return SingleProduct(
          productName: productList[index]['name'],
          productPicture: productList[index]['picture'],
          oldPrice: productList[index]['oldPrice'],
          prodPrice: productList[index]['price'],
        );
      },
    );
  }
}

//// singleProduct for grid view

class SingleProduct extends StatelessWidget {
  final productName;
  final productPicture;
  final oldPrice;
  final prodPrice;

  SingleProduct({
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
