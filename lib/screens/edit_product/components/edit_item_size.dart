import 'package:catalogoapp/models/item_size.dart';
import 'package:flutter/material.dart';

class EditItemSize extends StatelessWidget {

  const EditItemSize({this.size});

  final ItemSize? size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            initialValue: size!.name,
            decoration: const InputDecoration(
              labelText: 'Título',
              isDense: true,
            ),
          ),
        ),
        SizedBox(width: 4,),
        Expanded(
          child: TextFormField(
            initialValue: size!.stock.toString(),
            decoration: const InputDecoration(
              labelText: 'Estoque',
              isDense: true,
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(width: 4,),
        Expanded(
          child: TextFormField(
            initialValue: size!.price.toStringAsFixed(2),
              decoration: const InputDecoration(
                labelText: 'Preço',
                isDense: true,
              ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
      ],
    );
  }
}
