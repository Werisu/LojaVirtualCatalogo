import 'package:catalogoapp/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductManager extends ChangeNotifier{

  ProductManager() {

    _loadAllProducts();

  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Product> allProducts = [];

  String _search = "";

  String get search => _search;

  set search(String value){
    _search = value;
    notifyListeners();
  }

  List<Product> get filteredProducts {
    final List<Product> filteredProducts = [];

    if(search.isEmpty){
      filteredProducts.addAll(allProducts);
    }else{
      filteredProducts.addAll(
          allProducts.where((p) => p.name!.toLowerCase().contains(search.toLowerCase()))
      );
    }

    return filteredProducts;
  }

  Future<void> _loadAllProducts() async{
    final QuerySnapshot querySnapshot = await firestore.collection('products').get();

    allProducts = querySnapshot.docs.
    map((e) => Product.fromDocument(e)).toList();

    notifyListeners();
  }

  Product? findProductByID(String id){
    try{
      return allProducts.firstWhere((p) => p.id == id);
    }catch (e){
      return null;
    }
  }

}