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
      e.quantity++;
    } catch (e) {
      final cartProduct = CartProduct.fromProduct(product);
      cartProduct.addListener(_onItemUpdated);
      items.add(cartProduct);
      user!.cartReference.add(cartProduct.toCartItemMap());
    }
  }

  void _onItemUpdated(){
    print("==========> Atualizado");
  }

}