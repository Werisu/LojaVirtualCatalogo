import 'package:catalogoapp/models/section.dart';
import 'package:catalogoapp/screens/home/components/item_tile.dart';
import 'package:catalogoapp/screens/home/components/section_header.dart';
import 'package:flutter/material.dart';

class SectionList extends StatelessWidget {
  const SectionList(this.section);

  final Section section;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(section),
          SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index){
                return ItemTile(section.items[index]);
              },
              separatorBuilder: (_, __) => SizedBox(width: 4,),
              itemCount: section.items.length,
            ),
          )
        ],
      ),
    );
  }
}
