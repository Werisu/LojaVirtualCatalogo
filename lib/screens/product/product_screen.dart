import 'package:carousel_pro/carousel_pro.dart';
import 'package:catalogoapp/models/cart_manager.dart';
import 'package:catalogoapp/models/product.dart';
import 'package:catalogoapp/models/user_manager.dart';
import 'package:catalogoapp/screens/product/components/size_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Theme.of(context).primaryColor;

    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          title: Text(product.name!),
          centerTitle: true,
          actions: [
            Consumer<UserManager>(
              builder: (_, userManager, __){
                if(userManager.adminEnabled){
                  return IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: (){
                      Navigator.of(context).pushReplacementNamed(
                        '/edit_product',
                        arguments: product
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Carousel(
                images: product.images!.map((url){
                  return NetworkImage(url);
                }).toList(),
                dotSize: 4,
                dotSpacing: 15,
                dotBgColor: Colors.transparent,
                dotColor: primaryColor,
                autoplay: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    product.name!,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'A partir de',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13
                      ),
                    ),
                  ),
                  Text(
                    "R\$ ${product.basePrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColor
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 16, bottom: 8),
                    child: Text(
                      'Descri????o',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  Text(
                    product.description!,
                    style: TextStyle(
                      fontSize: 16
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 16, bottom: 8),
                    child: Text(
                      'Tamanhos',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                      product.sizes!.map((s){
                        return SizeWidget(size: s);
                      }).toList(),
                  ),
                  const SizedBox(height: 20,),
                  if(product.hasStock)
                    Consumer2<UserManager, Product>(
                      builder: (_, userManager, product, __){
                        return SizedBox(
                          height: 44,
                          child: ElevatedButton(
                            onPressed: (product.select != null) ? (){
                              if(userManager.isLoggedIn){
                                context.read<CartManager>().addToCart(product);
                                Navigator.pushNamed(context, '/cart');
                              } else {
                                Navigator.pushNamed(context, '/login');
                              }
                            } : null,
                            style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor
                            ),
                            child: Text(
                              userManager.isLoggedIn
                                  ? 'Adicionar ao Carrinho'
                                  : 'Entre para Comprar',
                              style: const TextStyle(
                                fontSize: 18
                              ),
                            ),
                          ),
                        );
                      },
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
