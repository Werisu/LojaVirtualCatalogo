import 'package:cloud_firestore/cloud_firestore.dart';

class Section {

  Section.fromDocument(DocumentSnapshot document){
    name = document.get('name') as String;
    type = document.get('type') as String;
  }

  String? name;
  String? type;

}