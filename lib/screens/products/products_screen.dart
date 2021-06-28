import 'package:catalogoapp/common/custom_drawer/custom_drawer.dart';
import 'package:catalogoapp/models/product-manager.dart';
import 'package:catalogoapp/screens/products/components/product_list_tile.dart';
import 'package:catalogoapp/screens/products/components/search_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showDialog(context: context, builder: (_)=>SearchDialog());
            },
          )
        ],
        title: const Text("Produtos"),
        centerTitle: true,
      ),
      body: Consumer<ProductManager>(
        builder: (_, productManager, __){
          return ListView.builder(
            padding: const EdgeInsets.all(4),
            itemCount: productManager.allProducts.length,
            itemBuilder: (_, index){
              return ProductListTile(productManager.allProducts[index]);
            },
          );
        },
      ),
    );
  }
}
