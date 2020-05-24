import 'package:flutter/material.dart';
import '../db/Catagory.dart';
import '../db/brand.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'AddProduct.dart';

enum Page {
  dashboard,
  manage
} // An enumeration is used for defining named constant values

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  Page _selectPage = Page.dashboard;
  MaterialColor active = Colors.red;
  MaterialColor disable = Colors.grey;
  GlobalKey<FormState> _catagoryFormDialogKey = GlobalKey();
  GlobalKey<FormState> _brandFormDialogKey = GlobalKey();
  var _catagoryController = TextEditingController();
  var _brandController = TextEditingController();
  CatagoryService _catagoryService = CatagoryService();
  BrandService _brandService = BrandService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// appar start
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Expanded(
                child: FlatButton.icon(
                    onPressed: () {
                      setState(() {
                        _selectPage = Page.dashboard;
                      });
                    },
                    icon: Icon(Icons.dashboard,
                        color:
                            _selectPage == Page.dashboard ? active : disable),
                    label: Text("Dashboard"))),
            Expanded(
                child: FlatButton.icon(
                    onPressed: () {
                      setState(() {
                        _selectPage = Page.manage;
                      });
                    },
                    icon: Icon(Icons.sort,
                        color: _selectPage == Page.manage ? active : disable),
                    label: Text("Manage"))),
          ],
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: _LoadSecreen(),
    );
  }

  /// contoel secreen
  Widget _LoadSecreen() {
    switch (_selectPage) {
      case Page.dashboard:
        return _dashboardSecreen();
        break;
      case Page.manage:
        return _manageSecreen();
        break;
    }
  }

  /// dashbord secreeen
  Widget _dashboardSecreen() {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text("Revenue",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0, color: Colors.grey)),
          subtitle: FlatButton.icon(
              onPressed: null,
              icon: Icon(Icons.attach_money, size: 20.0, color: Colors.green),
              label: Text("13000",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0, color: Colors.green))),
        ),
        Expanded(
          child: GridView(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            children: <Widget>[
              /// view the nymber of users
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  child: ListTile(
                    title: FlatButton.icon(
                        onPressed: null,
                        icon: Icon(Icons.people_outline),
                        label: Text("Users")),
                    subtitle: Text(
                      "7",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: active, fontSize: 60.0),
                    ),
                  ),
                ),
              ),

              /// view the number of catagories
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  child: ListTile(
                    title: FlatButton.icon(
                        onPressed: null,
                        icon: Icon(Icons.category),
                        label: Text("Catagories")),
                    subtitle: Text(
                      "23",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: active, fontSize: 60.0),
                    ),
                  ),
                ),
              ),

              /// view the number of products
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  child: ListTile(
                    title: FlatButton.icon(
                        onPressed: null,
                        icon: Icon(Icons.track_changes),
                        label: Text("Products")),
                    subtitle: Text(
                      "120",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: active, fontSize: 60.0),
                    ),
                  ),
                ),
              ),

              /// view the number of Sold
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  child: ListTile(
                    title: FlatButton.icon(
                        onPressed: null,
                        icon: Icon(Icons.tag_faces),
                        label: Text("Sold")),
                    subtitle: Text(
                      "13",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: active, fontSize: 60.0),
                    ),
                  ),
                ),
              ),

              /// view the number of Orders
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  child: ListTile(
                    title: FlatButton.icon(
                        onPressed: null,
                        icon: Icon(Icons.shopping_cart),
                        label: Text("Orders")),
                    subtitle: Text(
                      "5",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: active, fontSize: 60.0),
                    ),
                  ),
                ),
              ),

              /// view the number of closed
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  child: ListTile(
                    title: FlatButton.icon(
                        onPressed: null,
                        icon: Icon(Icons.close),
                        label: Text("Retuen")),
                    subtitle: Text(
                      "0",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: active, fontSize: 60.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// manage Secreen
  Widget _manageSecreen() {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.add),
          title: Text("Add product"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AddProduct()),
            );
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.change_history),
          title: Text("product list"),
          onTap: () {},
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.add_circle),
          title: Text("Add catagory"),
          onTap: () {
            _catagoryAlert();
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.category),
          title: Text("catagory list"),
          onTap: () {},
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.add_circle_outline),
          title: Text("Add brand"),
          onTap: () {
            _brandAlert();
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.library_books),
          title: Text("brand list"),
          onTap: () {},
        ),
        Divider(),
      ],
    );
  }

  /// catagory Dialog Alert
  void _catagoryAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _catagoryFormDialogKey,
        child: TextFormField(
          controller: _catagoryController,
          validator: (value) {
            if (value.isEmpty) {
              return "catagory cant be mpty";
            }
            return null;
          },
          decoration: InputDecoration(hintText: "add catagory"),
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              if (_catagoryController.text.isNotEmpty) {
                _catagoryService.createCatagory(_catagoryController.text);
                Fluttertoast.showToast(msg: "Catagory created");
                Navigator.pop(context);
              } else {
                Fluttertoast.showToast(msg: "please enter catagory name");
              }
            },
            child: Text("Add")),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel")),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }

  /// brand Dialoge alert
  void _brandAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _brandFormDialogKey,
        child: TextFormField(
          controller: _brandController,
          validator: (value) {
            if (value.isEmpty) {
              return "brand cant be mpty";
            }
            return null;
          },
          decoration: InputDecoration(hintText: "add brand"),
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              if (_brandController.text.isNotEmpty) {
                _brandService.createBrand(_brandController.text);
                Fluttertoast.showToast(msg: "Brand created");
                Navigator.pop(context);
              } else {
                Fluttertoast.showToast(msg: "please enter brand name");
              }
            },
            child: Text("Add")),
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel")),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }
}
