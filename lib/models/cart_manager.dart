import 'package:catalogoapp/models/cart_product.dart';
import 'package:catalogoapp/models/product.dart';

class CartManager {

  List<CartProduct> items = [];

  void addToCart(Product product){
    items.add(CartProduct.fromProduct(product));
  }

}