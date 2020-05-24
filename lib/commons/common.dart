import 'package:flutter/material.dart';

Color orange = Colors.deepOrange;
Color black = Colors.black;
Color white = Colors.white;

/// methods
///
void ChangeScreen(BuildContext context , Widget widget){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>widget) );
}

void ChangeScreenReplacement(BuildContext context , Widget widget){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>widget) );
}