import 'package:cloud_firestore/cloud_firestore.dart';

class ProductManager {

  ProductManager() {

    _loadAllProducts();

  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _loadAllProducts() async{
    final QuerySnapshot querySnapshot = await firestore.collection('products').get();

    for(DocumentSnapshot doc in querySnapshot.docs){
      print(doc.data());
    }
  }

}