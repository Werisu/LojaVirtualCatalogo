import 'package:catalogoapp/models/product.dart';
import 'package:flutter/material.dart';

class ImagesForm extends StatelessWidget {
  const ImagesForm(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: product.images,
      builder: (state){

      },
    );
  }
}
