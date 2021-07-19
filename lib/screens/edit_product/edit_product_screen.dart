import 'package:flutter/material.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Editar Produto"
        ),
        centerTitle: true,
      ),
    );
  }
}
