import 'package:basic_utils/basic_utils.dart';
import 'package:catalogoapp/common/custom_icon_button.dart';
import 'package:catalogoapp/models/home_manager.dart';
import 'package:catalogoapp/models/section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    final section = context.watch<Section>();

    if(homeManager.editing){

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: section.name,
                  decoration: const InputDecoration(
                    hintText: "Título",
                    isDense: true,
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 18
                  ),
                  onChanged: (text) => section.name = text,
                ),
              ),
              CustomIconButton(
                iconData: Icons.remove,
                color: Colors.white,
                onTap: (){
                  homeManager.removeSection(section);
                },
              ),
            ],
          ),
          if(section.error != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                section.error!,
                style: TextStyle(
                  color: Colors.red
                ),
              ),
            )
        ],
      );

    }else{

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          StringUtils.capitalize(section.name ?? " "),
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 18
          ),
        ),
      );

    }
  }
}
