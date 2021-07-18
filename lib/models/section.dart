import 'package:catalogoapp/models/section_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Section {

  Section.fromDocument(DocumentSnapshot document){
    name = document.get('name') as String;
    type = document.get('type') as String;
    items = (document.get('items') as List).map(
            (i) => SectionItem.fromMap(i as Map<String, dynamic>)).toList();
  }

  String? name;
  String? type;
  List<SectionItem>? items;

  @override
  String toString() {
    return 'Section{name: $name, type: $type, items: $items}';
  }
}