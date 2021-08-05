import 'package:catalogoapp/screens/eddress/components/cep_input_field.dart';
import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Endereço de Entrega',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16
              ),
            ),
            CepInputField()
          ],
        ),
      ),
    );
  }
}
