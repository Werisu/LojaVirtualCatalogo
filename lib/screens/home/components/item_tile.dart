import 'dart:io';

import 'package:catalogoapp/models/product-manager.dart';
import 'package:catalogoapp/models/section_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemTile extends StatelessWidget {
  const ItemTile(this.item);

  final SectionItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(item.product != ""){
          final product = context.read<ProductManager>()
              .findProductByID(item.product!);
          if(product != null){
            Navigator.of(context).pushNamed('/product', arguments: product);
          }
        }
      },
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
