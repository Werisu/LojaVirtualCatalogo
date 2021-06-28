import 'package:catalogoapp/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductManager extends ChangeNotifier{

  ProductManager() {

    _loadAllProducts();

  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Product> allProducts = [];

  Future<void> _loadAllProducts() async{
    final QuerySnapshot querySnapshot = await firestore.collection('products').get();

    allProducts = querySnapshot.docs.
    map((e) => Product.fromDocument(e)).toList();

    notifyListeners();
  }

}