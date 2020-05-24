import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CatagoryService {
  Firestore _firestore = Firestore.instance;
  String catagoryRef = "catagories";

  /// to greate catagory and put it into firestore DB.
  void createCatagory(String name) {
    var id = Uuid();
    String catagoryId = id.v1();
    _firestore
        .collection(catagoryRef)
        .document(catagoryId)
        .setData({'catagoryName': name}).catchError((e) => print(
            "Caragory service error ....................." + e.toString()));
  }

  /// to get all category form Db .
  Future<List<DocumentSnapshot>> getCatagories() {
    return _firestore.collection(catagoryRef).getDocuments().then((snap) {
      return snap.documents;
    });
  }

  /// to get spicific actagory based in to the pattern mane of spesific category.
  Future<List<String>> getSuggestion(String pattern) async {
    List<String> suggested = new List();
    await _firestore
        .collection(catagoryRef)
        .where("catagoryName", isEqualTo: pattern)
        .snapshots()
        .listen((data) {
      data.documents.forEach((doc) => suggested.add(doc['catagoryName']));
    });

    return suggested;
  }

}
