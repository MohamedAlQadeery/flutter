import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../db/Catagory.dart';
import '../db/brand.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../db/Product';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  Color wihte = Colors.white;
  Color gray = Colors.grey;
  Color black = Colors.black;
  Color red = Colors.red;

  CatagoryService _catagoryService = CatagoryService();
  BrandService _brandService = BrandService();
  ProductService _productService =ProductService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productQuantityController = TextEditingController();

  TextEditingController _productPriceController =TextEditingController();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> catagories = List<DocumentSnapshot>();
  List<DropdownMenuItem<String>> _brandsDropDown = <DropdownMenuItem<String>>[];
  String _cuurantCatagory = "test";
  String _CurrentBrand;
  Future snapsho;
  List<String> selectedAvaluableSize = <String>[];
  File _Image1;
  File _Image2;
  File _Image3;
  bool isLoding =false;

  ///*****************************************************************
  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> snapshot;
  CollectionReference collectionReference =
      Firestore.instance.collection("catagories");

  @override
  void initState() {
    super.initState();
    _getBrands();


  }

  List<DropdownMenuItem<String>> getBrandsDropdown() {
    List<DropdownMenuItem<String>> brandItems = new List();
    for (int index = 0; index < brands.length; index++) {
      setState(() {
        brandItems.insert(
            0,
            DropdownMenuItem(
              child: Text(brands[index].data['BrandName']),
              value: brands[index].data['BrandName'],
            ));
      });
    }
    return brandItems;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: wihte,
        elevation: 0.1,
        leading: InkWell(
          child: Icon(
            Icons.close,
            color: black,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Add product",
          style: TextStyle(color: black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: isLoding ? Center(child: CircularProgressIndicator ()):Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                          borderSide: BorderSide(
                              color: gray.withOpacity(0.8), width: 2.5),
                          onPressed: () {
                            _selectImage(
                                ImagePicker.pickImage(
                                    source: ImageSource.gallery),
                                1);
                          },
                          child: _displayImage(1)),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                        borderSide: BorderSide(
                            color: gray.withOpacity(0.8), width: 2.5),
                        onPressed: () {
                          _selectImage(
                              ImagePicker.pickImage(
                                  source: ImageSource.gallery),
                              2);
                        },
                        child: _displayImage(2),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                        borderSide: BorderSide(
                            color: gray.withOpacity(0.8), width: 2.5),
                        onPressed: () {
                          _selectImage(
                              ImagePicker.pickImage(
                                  source: ImageSource.gallery),
                              3);
                        },
                        child: _displayImage(3),
                      ),
                    ),
                  ),
                ],
              ),

              /// notify user to enter at most 10 character
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Enter a product name with 10 characters at maxmam ",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: red, fontSize: 12.0),
                ),
              ),

              /// add product name tet field
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _productNameController,
                  decoration: InputDecoration(
                    hintText: 'Product name',
                    focusColor: Colors.blueAccent,
                    hoverColor: Colors.blueAccent,
                  ),
                ),
              ),

              /// Select category
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'add category',
                        border: OutlineInputBorder(),
                      )),
                  suggestionsCallback: (pattern) async {
                    List<String> completer =
                        await _catagoryService.getSuggestion(pattern);
                    return completer;
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      leading: Icon(Icons.category),
                      title: Text(suggestion),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    setState(() {
                      _cuurantCatagory = suggestion;
                    });
                  },
                ),
              ),

              /// Select brand
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Brand  :  ",
                      style: TextStyle(color: Colors.blue),
                    ),
                    DropdownButton(
                      items: _brandsDropDown,
                      onChanged: changeSelectedBrand,
                      value: _CurrentBrand,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: _productQuantityController,
//                  initialValue: '1',
                  keyboardType: TextInputType.number,

                  decoration: InputDecoration(
                    hintText: 'Quantity',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'you must enter the product name';
                    }
                    return null;
                  },
                ),
              ),
              /// price
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: _productPriceController,
                 // initialValue: '0.00',
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'price',
                    hintText: 'Price',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'you must enter the product name';
                    }
                    return null;
                  },
                ),
              ),
              Text("Avaliable Size"),

              /// size assin by latter
              Row(
                children: <Widget>[
                  Checkbox(
                      value: selectedAvaluableSize.contains('XS'),
                      onChanged: (value) => changeSelectedSize('XS')),
                  Text('XS'),
                  Checkbox(
                      value: selectedAvaluableSize.contains('S'),
                      onChanged: (value) => changeSelectedSize('S')),
                  Text('S'),
                  Checkbox(
                      value: selectedAvaluableSize.contains('M'),
                      onChanged: (value) => changeSelectedSize('M')),
                  Text('M'),
                  Checkbox(
                      value: selectedAvaluableSize.contains('L'),
                      onChanged: (value) => changeSelectedSize('L')),
                  Text('L'),
                  Checkbox(
                      value: selectedAvaluableSize.contains('XL'),
                      onChanged: (value) => changeSelectedSize('XL')),
                  Text('XL'),
                  Checkbox(
                      value: selectedAvaluableSize.contains('XXL'),
                      onChanged: (value) => changeSelectedSize('XXL')),
                  Text('XXL'),
                ],
              ),
              // size
              Row(
                children: <Widget>[
                  Checkbox(
                      value: selectedAvaluableSize.contains('28'),
                      onChanged: (value) => changeSelectedSize('28')),
                  Text('28'),
                  Checkbox(
                      value: selectedAvaluableSize.contains('30'),
                      onChanged: (value) => changeSelectedSize('30')),
                  Text('30'),
                  Checkbox(
                      value: selectedAvaluableSize.contains('32'),
                      onChanged: (value) => changeSelectedSize('32')),
                  Text('32'),
                  Checkbox(
                      value: selectedAvaluableSize.contains('34'),
                      onChanged: (value) => changeSelectedSize('34')),
                  Text('34'),
                  Checkbox(
                      value: selectedAvaluableSize.contains('36'),
                      onChanged: (value) => changeSelectedSize('36')),
                  Text('36'),
                  Checkbox(
                      value: selectedAvaluableSize.contains('38'),
                      onChanged: (value) => changeSelectedSize('38')),
                  Text('38'),
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                      value: selectedAvaluableSize.contains('40'),
                      onChanged: (value) => changeSelectedSize('40')),
                  Text('40'),
                  Checkbox(
                      value: selectedAvaluableSize.contains('42'),
                      onChanged: (value) => changeSelectedSize('42')),
                  Text('42'),
                  Checkbox(
                      value: selectedAvaluableSize.contains('44'),
                      onChanged: (value) => changeSelectedSize('44')),
                  Text('44'),
                  Checkbox(
                      value: selectedAvaluableSize.contains('46'),
                      onChanged: (value) => changeSelectedSize('46')),
                  Text('46'),
                  Checkbox(
                      value: selectedAvaluableSize.contains('48'),
                      onChanged: (value) => changeSelectedSize('48')),
                  Text('48'),
                  Checkbox(
                      value: selectedAvaluableSize.contains('50'),
                      onChanged: (value) => changeSelectedSize('38')),
                  Text('50'),
                ],
              ),

              /// button for add product
              RaisedButton(
                color: Colors.blue,
                textColor: wihte,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  validateAndUoloadImage();
                  print("Add product");
                },
                child: Text("Add product "),
              )
            ],
          ),
        ),
      ),
    );
  }

  _getBrands() async {
    List<DocumentSnapshot> data = await _brandService.getBrands();
    setState(() {
      brands = data;
      _brandsDropDown = getBrandsDropdown();
      _CurrentBrand = brands[0].data['BrandName'];
    });
  }

  changeSelectedBrand(String selectedBrand) {
    setState(() {
      _CurrentBrand = selectedBrand;
    });
  }

  void changeSelectedSize(String size) {
    if (selectedAvaluableSize.contains(size)) {
      setState(() {
        selectedAvaluableSize.remove(size);
      });
    } else {
      setState(() {
        selectedAvaluableSize.insert(0, size);
      });
    }
  }

  /// SELECT IMAGE from galary
  void _selectImage(Future<File> pickImage, int indexImage) async {
    File tempImag = await pickImage;

    switch (indexImage) {
      case 1:
        setState(() => _Image1 = tempImag);
        break;
      case 2:
        setState(() => _Image2 = tempImag);
        break;
      case 3:
        setState(() => _Image3 = tempImag);
        break;
    }
  }

  /// displayImage from galary .
  Widget _displayImage(int imageNumber) {
    File currentImage;
    switch (imageNumber) {
      case 1:
        currentImage = _Image1;
        break;
      case 2:
        currentImage = _Image2;
        break;
      case 3:
        currentImage = _Image3;
        break;
    }
    if (currentImage == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: Icon(
          Icons.add,
          color: gray,
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: Image.file(
          currentImage,
          fit: BoxFit.fill,
          width: double.infinity,
        ),
      );
    }
  }


/// upload image to the Ftrstore
  Future<void> validateAndUoloadImage() async {
    setState(() {
      isLoding=true;
    });
 if(_formKey.currentState.validate()){
   if(_Image1 !=null && _Image2 !=null && _Image3 !=null){
        if(selectedAvaluableSize.isNotEmpty){
  String imagUrl1;
  String imagUrl2;
  String imagUrl3;
  final FirebaseStorage  storage =FirebaseStorage.instance;

  final String picture1 = "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpeg";
  StorageUploadTask task1 =storage.ref().child(picture1).putFile(_Image1);

  final String picture2 = "2${DateTime.now().millisecondsSinceEpoch.toString()}.jepg";
  StorageUploadTask task2 =storage.ref().child(picture2).putFile(_Image2);

  final String picture3 = "3${DateTime.now().millisecondsSinceEpoch.toString()}.jepg";
  StorageUploadTask task3 =storage.ref().child(picture3).putFile(_Image3);

  StorageTaskSnapshot snapshot1 = await task1.onComplete.then((snapshot)=>snapshot);
  StorageTaskSnapshot snapshot2= await task2.onComplete.then((snapshot)=>snapshot);
   task3.onComplete.then((snapshot3)async{
    imagUrl1= await snapshot1.ref.getDownloadURL();
    imagUrl2= await snapshot2.ref.getDownloadURL();
    imagUrl3= await snapshot3.ref.getDownloadURL();
    List<String> imageList =[imagUrl1,imagUrl2, imagUrl3];
    _productService.uploadProduct(productName: _productNameController.text,price: double.parse(_productPriceController.text),sizes: selectedAvaluableSize ,Images: imageList,quantity: int.parse(_productQuantityController.text,) );

    _formKey.currentState.reset();
    setState(() {
      isLoding = false;
    });
    Fluttertoast.showToast(msg: "product add");
    Navigator.pop(context);

   });
        }else{
          setState(() {
            isLoding = false;
          });
          Fluttertoast.showToast(msg: "select at least fontsize");
        }
   }else{
     Fluttertoast.showToast(msg: "all the images must be provided");
   }


 }


  }
}
