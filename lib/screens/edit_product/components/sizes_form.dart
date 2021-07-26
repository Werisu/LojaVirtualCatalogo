import 'package:catalogoapp/common/custom_icon_button.dart';
import 'package:catalogoapp/models/item_size.dart';
import 'package:catalogoapp/models/product.dart';
import 'package:catalogoapp/screens/edit_product/components/edit_item_size.dart';
import 'package:flutter/material.dart';

class SizesForm extends StatelessWidget {
  const SizesForm(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<ItemSize>>(
          initialValue: product.sizes,
          builder: (state){
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Tamanhos',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    CustomIconButton(
                      iconData: Icons.add,
                      color: Colors.black,
                      onTap: (){
                        state.value!.add(ItemSize());
                        state.didChange(state.value);
                      },
                    )
                  ],
                ),
                Column(
                  children: state.value!.map((size){
                    return EditItemSize(
                      size: size,
                      onRemove: (){
                        state.value!.remove(size);
                        state.didChange(state.value);
                      },
                    );
                  }).toList(),
                ),
              ],
            );
          },
        );
  }
}
