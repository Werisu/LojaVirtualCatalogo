import 'package:catalogoapp/models/item_size.dart';
import 'package:flutter/material.dart';

class SizeWidget extends StatelessWidget {
  const SizeWidget({required this.size});

  final ItemSize size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: !(size.stock > 0) ? Colors.red.withAlpha(50) : Colors.grey
        )
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: !(size.stock > 0) ? Colors.red.withAlpha(50) : Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Text(
              size.name.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "R\$ ${size.price.toStringAsFixed(2)}",
              style: TextStyle(
                color: !(size.stock > 0) ? Colors.red.withAlpha(50) : Colors.grey
              ),
            ),
          )
        ],
      ),
    );
  }
}
