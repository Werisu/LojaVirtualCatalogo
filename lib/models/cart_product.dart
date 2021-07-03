import 'package:catalogoapp/models/item_size.dart';
import 'package:catalogoapp/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CartProduct extends ChangeNotifier{

  CartProduct.fromProduct(this.product){
   productId = product!.id;
   quantity = 1;
   size = product!.select!.name;
  }

  CartProduct.fromDocument(DocumentSnapshot document){
    id = document.id;
    productId = document.get('pid') as String;
    quantity = document.get('quantity') as int;
    size = document.get('size') as String;

    firestore.doc('products/$productId').get().then(
            (doc) => product = Product.fromDocument(doc)
    );
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  late String id;

  String? productId;
  late int quantity;
  String? size;

  Product? product;

  ItemSize? get itemSize {
    if(product == null) return null;
    return product!.findSize(size);
  }

  num get uniPrice {
    if(product == null) return 0;
    return itemSize!.price;
  }

  Map<String, dynamic> toCartItemMap(){
    return{
      'pid' : productId,
      'quantity' : quantity,
      'size' : size
    };
  }

  bool stackable(Product product){
    return product.id == productId && product.select!.name == size;
  }

  void increment(){
    quantity++;
    notifyListeners();
  }

  void decrement(){
    quantity--;
    notifyListeners();
  }

}