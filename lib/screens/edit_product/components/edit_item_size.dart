import 'package:catalogoapp/common/custom_icon_button.dart';
import 'package:catalogoapp/models/item_size.dart';
import 'package:flutter/material.dart';

class EditItemSize extends StatelessWidget {

  const EditItemSize({Key? key, this.size, this.onRemove, this.onMoveDown, this.onMoveUp}) : super (key: key);

  final ItemSize? size;
  final VoidCallback? onRemove;
  final VoidCallback? onMoveUp;
  final VoidCallback? onMoveDown;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size!.name!.toUpperCase(),
            decoration: const InputDecoration(
              labelText: 'Título',
              isDense: true,
            ),
          ),
        ),
        SizedBox(width: 4,),
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size!.stock?.toString(),
            decoration: const InputDecoration(
              labelText: 'Estoque',
              isDense: true,
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(width: 4,),
        Expanded(
          flex: 40,
          child: TextFormField(
            initialValue: size!.price?.toStringAsFixed(2),
              decoration: const InputDecoration(
                labelText: 'Preço',
                isDense: true,
                prefixText: 'R\$'
              ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
        CustomIconButton(
          iconData: Icons.remove,
          color: Colors.red,
          onTap: onRemove,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_up,
          color: Colors.black,
          onTap: onMoveUp,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_down,
          color: Colors.black,
          onTap: onMoveDown,
        )
      ],
    );
  }
}
