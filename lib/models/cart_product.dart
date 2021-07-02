import 'package:catalogoapp/models/item_size.dart';
import 'package:catalogoapp/models/product.dart';

class CartProduct{

  CartProduct.fromProduct(this.product){
   productId = product!.id;
   quantity = 1;
   size = product!.select!.name;
  }

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