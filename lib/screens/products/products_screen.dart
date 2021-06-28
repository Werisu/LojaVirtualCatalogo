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
          Consumer<ProductManager>(
            builder: (_, productManager, __){
              if(productManager.search.isEmpty){
                return IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async{
                    final search = await showDialog<String>(
                        context: context,
                        builder: (_)=>SearchDialog(productManager.search)
                    );
                    if(search != ""){
                      productManager.search = search!;
                    }
                  },
                );
              } else {
                return IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () async{
                      productManager.search = "";
                  },
                );
              }
            },
          )
        ],
        title: Consumer<ProductManager>(
          builder: (_, productManager, __){
            if(productManager.search.isEmpty){
              return const Text("Produtos");
            } else {
              return LayoutBuilder(
                  builder: (_, constraints){
                    return GestureDetector(
                      onTap: () async{
                        final search = await showDialog(
                            context: context,
                            builder: (_)=>SearchDialog(productManager.search)
                        );
                        if(search != ""){
                          productManager.search = search;
                        }
                      },
                      child: Container(
                        width: constraints.biggest.width,
                          child: Text(productManager.search, textAlign: TextAlign.center,)
                      ),
                    );
                  }
              );
            }
          },
        ),
        centerTitle: true,
      ),
      body: Consumer<ProductManager>(
        builder: (_, productManager, __){
          final filteredProducts = productManager.filteredProducts;
          return ListView.builder(
            padding: const EdgeInsets.all(4),
            itemCount: filteredProducts.length,
            itemBuilder: (_, index){
              return ProductListTile(filteredProducts[index]);
            },
          );
        },
      ),
    );
  }
}
