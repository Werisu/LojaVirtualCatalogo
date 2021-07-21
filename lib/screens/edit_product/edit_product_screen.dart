import 'package:catalogoapp/models/product.dart';
import 'package:catalogoapp/screens/edit_product/components/images_form.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatelessWidget {
  EditProductScreen(this.product);

  final Product product;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Editar Produto"
        ),
        centerTitle: true,
      ),
      body: Form(
        key: formkey,
        child: ListView(
          children: [
            ImagesForm(product),
            ElevatedButton(
              onPressed: (){
                if(formkey.currentState!.validate()){
                  print("Válido");
                }else{
                  print("inválido");
                }
              },
              child: const Text("Salvar"),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor
              ),
            )
          ],
        ),
      ),
    );
  }
}
