import 'package:catalogoapp/models/item_size.dart';
import 'package:catalogoapp/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartProduct{

  CartProduct.fromProduct(this.product){
   productId = product!.id;
   quantity = 1;
   size = product!.select!.name;
  }

  CartProduct.fromDocument(DocumentSnapshot document){
    productId = document.get('pid') as String;
    quantity = document.get('quantity') as int;
    size = document.get('size') as String;

    firestore.doc('products/$productId').get().then(
            (doc) => product = Product.fromDocument(doc)
    );
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? productId;
  int? quantity;
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

}