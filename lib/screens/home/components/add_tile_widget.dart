import 'dart:io';

import 'package:catalogoapp/models/section.dart';
import 'package:catalogoapp/models/section_item.dart';
import 'package:catalogoapp/screens/edit_product/components/image_sourch_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTileWidget extends StatelessWidget {
  const AddTileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final section = context.watch<Section>();

    void onImageSelected(File file){
      section.addItem(SectionItem(image: file));
      Navigator.of(context).pop();
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
