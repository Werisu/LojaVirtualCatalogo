import 'package:catalogoapp/common/price_card.dart';
import 'package:catalogoapp/models/cart_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/cart_tile.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho"),
        centerTitle: true,
      ),
      body: Consumer<CartManager>(
        builder: (_, cartManager, __){
          return ListView(
            children: [
              Column(
                children: cartManager.items.map(
                        (cartProduct)=>CartTile(cartProduct))
                    .toList(),
              ),
              PriceCard(
                buttonText: 'Continuar para Entrega',
                onPressed: cartManager.isCartValid ? (){
                  Navigator.of(context).pushNamed('/eddress');
                } : null,
              ),
            ],
          );
        },
      ),
    );
  }
}
