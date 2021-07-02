import 'package:catalogoapp/models/cart_product.dart';
import 'package:catalogoapp/models/product.dart';
import 'package:catalogoapp/models/user.dart';
import 'package:catalogoapp/models/user_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartManager {

  List<CartProduct> items = [];

  UserData? user;

  void updateUser(UserManager userManager){
    user = userManager.user;
    items.clear();

    if(user != null){
      _loadCartItems();
    }
  }

  Future<void> _loadCartItems() async{
    final QuerySnapshot cartSnap = await user!.cartReference.get();

    items = cartSnap.docs.map((d) => CartProduct.fromDocument(d)).toList();
  }

  void addToCart(Product product){
    items.add(CartProduct.fromProduct(product));
  }

}