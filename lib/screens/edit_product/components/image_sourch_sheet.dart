import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageSourceSheet extends StatelessWidget {
  const ImageSourceSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  }
}
