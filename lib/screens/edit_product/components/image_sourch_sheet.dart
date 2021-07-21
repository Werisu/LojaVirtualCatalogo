import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  ImageSourceSheet({required this.onImageSelected});

  final ImagePicker imagePicker = ImagePicker();

  final Function(File) onImageSelected;

  Future<void> editImage(String path, BuildContext context) async{
    final File? croppedFile = await ImageCropper.cropImage(
      sourcePath: path,
      aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: "Editar Inagen",
        toolbarColor: Theme.of(context).primaryColor,
        toolbarWidgetColor: Colors.white
      ),
      iosUiSettings: const IOSUiSettings(
        title: "Editar Imagem",
        cancelButtonTitle: "Cancelar",
        doneButtonTitle: "Concluir"
      )
    );
    if(croppedFile != null){
      onImageSelected(croppedFile);
    }
  }

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
                  editImage(file!.path, context);
                },
                child: Text("Câmera")
            ),
            TextButton(
                onPressed: () async{
                  final file = await imagePicker.pickImage(source: ImageSource.gallery);
                  editImage(file!.path, context);
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
            onPressed: () async{
              final XFile? file = await imagePicker.pickImage(source: ImageSource.camera, imageQuality: 90);
              //final file = await imagePicker.pickImage(source: ImageSource.camera);
              editImage(file!.path, context);
            },
            child: const Text("Câmera")
          ),
          CupertinoActionSheetAction(
              onPressed: () async{
                final XFile? file = await imagePicker.pickImage(source: ImageSource.camera, imageQuality: 90);
                //final file = await imagePicker.pickImage(source: ImageSource.camera);
                editImage(file!.path, context);
              },
              child: const Text("Galeria")
          ),
        ],
      );
  }
}
