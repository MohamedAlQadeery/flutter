import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
class BrandService{
  Firestore _firestore = Firestore.instance;
  String brandRef ="brand";

 /// to greate brand and put it into firestore DB.
  void createBrand(String name){
    var id = Uuid();
    String BrandId =id.v1();
    _firestore.collection(brandRef).document(BrandId).setData({'BrandName':name}).catchError((e)=>print("erorr BrandService _________________ : "+ e.toString()));
  }

  /// to get all brand form database
Future<List<DocumentSnapshot>> getBrands(){
return _firestore.collection(brandRef).getDocuments().then((snap){
  return snap.documents;
});
}


  /// to get specific Brand based in to the pattern mane of specific category.
  Future<List<String>> getSuggestion(String pattern) async {
    List<String> suggested = new List();
    await _firestore
        .collection(brandRef)
        .where("BrandName", isEqualTo: pattern)
        .snapshots()
        .listen((data) {
      data.documents.forEach((doc) => suggested.add(doc['BrandName']));
    });

    return suggested;
  }
}