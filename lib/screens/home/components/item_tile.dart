import 'dart:io';

import 'package:catalogoapp/models/home_manager.dart';
import 'package:catalogoapp/models/product-manager.dart';
import 'package:catalogoapp/models/product.dart';
import 'package:catalogoapp/models/section.dart';
import 'package:catalogoapp/models/section_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemTile extends StatelessWidget {
  const ItemTile(this.item);

  final SectionItem item;

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();

    return GestureDetector(
      onTap: (){
        if(item.product != ""){
          final product = context.read<ProductManager>()
              .findProductByID(item.product as String);
          if(product != null){
            Navigator.of(context).pushNamed('/product', arguments: product);
          }
        }
      },
      onLongPress: homeManager.editing ? (){
        showDialog(
            context: context,
            builder: (_){
              final product = context.read<ProductManager>()
                  .findProductByID(item.product as String);
              return AlertDialog(
                title: const Text("Editar Item"),
                content: product != null
                  ? ListTile(
                  contentPadding: EdgeInsets.zero,
                    leading: Image.network(product.images!.first),
                    title: Text(product.name!),
                    subtitle: Text("R\$ ${product.basePrice.toStringAsFixed(2)}"),
                  )
                  : null,
                actions: [
                  TextButton(
                    onPressed: (){
                      /// quando estamos dentro de uma função utilizamos /read/
                      /// e quando estamos dentro do build utilizamos /watch/
                      context.read<Section>().removeItem(item);
                      Navigator.of(context).pop();
                    },
                    child: const Text("Excluir"),
                    style: TextButton.styleFrom(
                      primary: Colors.red,
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      if(product != null){
                        item.product = null;
                      } else {
                        final Product? product =
                          await Navigator.of(context).pushNamed('/select_product') as Product;
                        item.product = product?.id;

                      }
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      product != null
                          ? 'Desvincular'
                          : 'Vincular'
                    ),
                    style: TextButton.styleFrom(
                        textStyle: TextStyle(
                            color: Colors.red
                        )
                    ),
                  )
                ],
              );
            }
        );
      } : null,
      child: AspectRatio(
        aspectRatio: 1,
        child: item.image is String ?
        FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: item.image,
          fit: BoxFit.cover,
        )
        : Image.file(item.image as File, fit: BoxFit.cover,),
      ),
    );
  }
}
