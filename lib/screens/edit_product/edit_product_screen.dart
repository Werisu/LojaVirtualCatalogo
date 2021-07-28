import 'package:catalogoapp/models/product-manager.dart';
import 'package:catalogoapp/models/product.dart';
import 'package:catalogoapp/screens/edit_product/components/images_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/sizes_form.dart';

class EditProductScreen extends StatelessWidget {
  EditProductScreen(Product? p) :
      editing = p != null,
        product = p != null ? p.clone() : Product();

  final Product product;
  final  bool editing;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(editing ? "Editar Produto" : "Novo Produto"),
          centerTitle: true,
        ),
        body: Form(
          key: formkey,
          child: ListView(
            children: [
              ImagesForm(product),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      initialValue: product.name,
                      decoration: InputDecoration(
                          hintText: 'Título', border: InputBorder.none),
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      validator: (name) {
                        if (name!.length < 6) {
                          return "Título muito curto";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (name) => product.name = name,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'A partir de',
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        'R\$ ...',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Descrição',
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextFormField(
                      initialValue: product.description,
                      style: TextStyle(fontWeight: FontWeight.w500),
                      decoration: const InputDecoration(
                        hintText: "Descrição",
                        border: InputBorder.none,
                      ),
                      maxLines: null,
                      validator: (desc) {
                        if (desc!.length < 10) return "Descrição muito curta";
                        return null;
                      },
                      onSaved: (desc) => product.description = desc,
                    ),
                    SizesForm(product),
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer<Product>(
                      builder: (_, product, __){
                        return SizedBox(
                          height: 44,
                          child: ElevatedButton(
                            onPressed: !product.loading ? () async{
                              if (formkey.currentState!.validate()) {
                                formkey.currentState!.save();

                                await product.save();

                                context.read<ProductManager>().update(product);

                                Navigator.of(context).pop();
                              } else {
                                print("inválido");
                              }
                            } : null,
                            child: product.loading ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            ) : const Text("Salvar"),
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColor,
                                textStyle: TextStyle(fontSize: 18)),
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
      ),
    );
  }
}
