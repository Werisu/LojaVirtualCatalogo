import 'package:catalogoapp/models/product.dart';

class CartProduct{

  CartProduct.fromProduct(this.product){
   productId = product.id;
   quantity = 1;
   size = product.select!.name;
  }

  String? productId;
  int? quantity;
  String? size;
  Product product;

}