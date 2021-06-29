import 'package:catalogoapp/models/item_size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {

  Product.fromDocument(DocumentSnapshot document){
    id = document.id;
    name = document['name'] as String;
    description = document['description'] as String;
    images = List<String>.from(document.get('images') as List<dynamic>);
    isSizes(document);
    print(sizes);
  }

  late String id;
  late String name;
  late String description;
  late List<String> images;
  late List<ItemSize> sizes = [];

  void isSizes(DocumentSnapshot document){
    try{

      sizes = (document.get('sizes') as List<dynamic>).map(
              (s) => ItemSize.fromMap(s as Map<String, dynamic>)).toList();

    }catch(e){
      print(e);
    }
  }

}