import 'package:catalogoapp/models/item_size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Product extends ChangeNotifier {

  Product.fromDocument(DocumentSnapshot document){
    id = document.id;
    name = document['name'] as String;
    description = document['description'] as String;
    images = List<String>.from(document.get('images') as List<dynamic>);
    isSizes(document);
  }

  late String id;
  late String name;
  late String description;
  late List<String> images;
  late List<ItemSize>? sizes;

  ItemSize? _selectSize;
  ItemSize? get select{
    try{
      return _selectSize;
    }catch (e){
      print("Erro no product.dar -> get _selectSize $e");
      return null;
    }
  }
  set selectSize(ItemSize value) {
    this._selectSize = value;
    notifyListeners();
  }

  void isSizes(DocumentSnapshot document){
    try{

      sizes = (document.get('sizes') as List<dynamic>).map(
              (s) => ItemSize.fromMap(s as Map<String, dynamic>)).toList();

    }catch(e){
      sizes = [];
    }
  }

  int get totalStock{
    int stock = 0;
    for(final size in sizes!){
      stock += size.stock;
    }
    print(stock);
    return stock;
  }

  bool get hasStock{
    return totalStock > 0;
  }

  ItemSize? findSize(String? name) {
    try{
      return sizes!.firstWhere((s) => s.name == name);
    }catch(e){
      return null;
    }
  }

}