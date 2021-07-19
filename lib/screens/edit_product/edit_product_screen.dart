import 'package:catalogoapp/models/product.dart';
import 'package:catalogoapp/screens/edit_product/components/images_form.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Editar Produto"
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ImagesForm(product),
        ],
      ),
    );
  }
}
