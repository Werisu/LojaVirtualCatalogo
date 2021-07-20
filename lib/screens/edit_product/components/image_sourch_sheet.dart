import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageSourceSheet extends StatelessWidget {
  const ImageSourceSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(Platform.isAndroid)
      return BottomSheet(
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
                onPressed: (){

                },
                child: Text("Câmera")
            ),
            TextButton(
                onPressed: (){

                },
                child: Text("Galeria")
            )
          ],
        ),
        onClosing: (){},
      );
    else
      return CupertinoActionSheet(
        title: const Text("Selecionar Foto para o Item"),
        message: const Text("Escolha a origem da foto"),
        cancelButton: CupertinoActionSheetAction(
          child: const Text("Cancelar"),
          onPressed: Navigator.of(context).pop,
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: (){

            },
            child: const Text("Câmera")
          ),
          CupertinoActionSheetAction(
              onPressed: (){

              },
              child: const Text("Galeria")
          ),
        ],
      );
  }
}
