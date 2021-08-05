import 'package:catalogoapp/screens/eddress/components/address_card.dart';
import 'package:flutter/material.dart';

class EddressScreen extends StatelessWidget {
  const EddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrega'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AddressCard()
        ],
      ),
    );
  }
}
