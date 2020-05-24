import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class UserServise {
  Firestore  _firestore = Firestore.instance;
  String collection = "users";

 void createUser(Map data) {
   _firestore.collection(collection).document(data["userId"]).setData(data);

  }
}
