import 'package:catalogoapp/models/cart_product.dart';
import 'package:catalogoapp/models/product.dart';
import 'package:catalogoapp/models/user.dart';
import 'package:catalogoapp/models/user_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CartManager extends ChangeNotifier {

  List<CartProduct> items = [];

  UserData? user;

  num productsPrice = 0.0;

  void updateUser(UserManager userManager){
    user = userManager.user;
    items.clear();

    if(user != null){
      _loadCartItems();
    }
  }

  Future<void> _loadCartItems() async{

    try{
      final QuerySnapshot cartSnap = await user!.cartReference.get();

      items = cartSnap.docs.map(
              (d) => CartProduct.fromDocument(d)..addListener(_onItemUpdated)
      ).toList();
    }catch(e){
      print("erro ao carregar itens");
    }

    print("carregando itens");

  }

  void addToCart(Product product){
    try {
      final e = items.firstWhere((p) => p.stackable(product));
      e.increment();
    } catch (e) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdated);
      items.add(cartProduct);
      user!.cartReference.add(cartProduct.toCartItemMap()).then((doc) => cartProduct.id = doc.id);
      _onItemUpdated();
    }
  }
  
  void removeOfCart(CartProduct cartProduct){
    items.removeWhere((p) => p.id == cartProduct.id);
    user!.cartReference.doc(cartProduct.id).delete();
    cartProduct.removeListener(_onItemUpdated);
    notifyListeners();
  }

  void _onItemUpdated(){
    productsPrice = 0.0;

    for(int i = 0; i<items.length; i++){
      final cartProduct = items[i];

      if(cartProduct.quantity == 0){
        removeOfCart(cartProduct);
        i--;
        continue;
      }

      productsPrice += cartProduct.totalPrice;

      _updateCartProduct(cartProduct);
    }

    notifyListeners();

    print(productsPrice);
  }

  void _updateCartProduct(CartProduct cartProduct){
    if(cartProduct.id != null){
      user!.cartReference.doc(cartProduct.id)
          .update(cartProduct.toCartItemMap());
    }
  }
  
  bool get isCartValid {
    for(final cartProduct in items){
      if(!cartProduct.hasStock){
        return false;
      }
    }
    return true;
  }

}