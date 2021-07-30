import 'dart:io';

import 'package:catalogoapp/screens/edit_product/components/image_sourch_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTileWidget extends StatelessWidget {
  const AddTileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onImageSelected(File file){

    }

    return AspectRatio(
      aspectRatio: 1,
      child: GestureDetector(
        onTap: (){
          if(Platform.isAndroid){
            showModalBottomSheet(
                context: context, 
                builder: (context) =>
                    ImageSourceSheet(onImageSelected: onImageSelected),
            );
          } else {
            showCupertinoModalPopup(
                context: context,
                builder: (context) =>
                    ImageSourceSheet(onImageSelected: onImageSelected)
            );
          }
        },
        child: Container(
          color: Colors.white.withAlpha(30),
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
