import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  ImageSourceSheet({required this.onImageSelected});

  final ImagePicker imagePicker = ImagePicker();

  final Function(File) onImageSelected;

  @override
  Widget build(BuildContext context) {
    if(Platform.isAndroid)
      return BottomSheet(
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
                onPressed: () async{
                  final XFile? file = await imagePicker.pickImage(source: ImageSource.camera, imageQuality: 90);
                  //final file = await imagePicker.pickImage(source: ImageSource.camera);
                  onImageSelected(File(file!.path));
                },
                child: Text("Câmera")
            ),
            TextButton(
                onPressed: () async{
                  final file = await imagePicker.pickImage(source: ImageSource.gallery);
                  onImageSelected(File(file!.path));
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
