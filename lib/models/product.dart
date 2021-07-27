import 'package:catalogoapp/models/item_size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Product extends ChangeNotifier {
  Product({this.name, this.description, this.id, this.images, this.sizes}){
    images = images ?? [];
    sizes = sizes ?? [];
    name = name ?? "";
    description = description ?? "";
  }

  Product.fromDocument(DocumentSnapshot document) {
    id = document.id;
    name = document['name'] as String;
    description = document['description'] as String;
    images = List<String>.from(document.get('images') as List<dynamic>);
    isSizes(document);
  }

  late String? id;
  late String? name;
  late String? description;
  late List<String>? images;
  late List<ItemSize>? sizes;

  List<dynamic>? newImages;

  ItemSize? _selectSize;
  ItemSize? get select {
    try {
      return _selectSize;
    } catch (e) {
      print("Erro no product.dar -> get _selectSize $e");
      return null;
    }
  }

  set selectSize(ItemSize value) {
    this._selectSize = value;
    notifyListeners();
  }

  void isSizes(DocumentSnapshot document) {
    try {
      sizes = (document.get('sizes') as List<dynamic>)
          .map((s) => ItemSize.fromMap(s as Map<String, dynamic>))
          .toList();
    } catch (e) {
      sizes = [];
    }
  }

  int get totalStock {
    int stock = 0;
    for (final size in sizes!) {
      stock += size.stock!;
    }
    return stock;
  }

  bool get hasStock {
    return totalStock > 0;
  }

  num get basePrice {
    num lowest = double.infinity;
    for (final size in sizes!) {
      if (size.price! < lowest && (size.stock != 0)) lowest = size.price!;
    }
    return lowest;
  }

  ItemSize? findSize(String? name) {
    try {
      return sizes!.firstWhere((s) => s.name == name);
    } catch (e) {
      return null;
    }
  }

  Product clone(){
    return Product(
      id: id,
      name: name,
      description: description,
      images: List.from(images as List<dynamic>),
      sizes: sizes!.map((size) => size.clone()).toList()
    );
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, description: $description, images: $images, sizes: $sizes, newImages: $newImages}';
  }
}
