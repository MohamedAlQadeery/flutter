import 'package:flutter/material.dart';
import 'package:flutter_app1/pages/Admin.dart';
import 'package:flutter_app1/pages/Login.dart';


void main() {
  runApp(new MaterialApp(
    //debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.red.shade900,
    ),
    // home:Login(),
    home: Login(),
  ));
}
