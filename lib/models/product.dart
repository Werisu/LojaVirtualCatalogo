import 'dart:io';

import 'package:catalogoapp/models/item_size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

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

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.doc('products/$id');

  Reference get storageRef => storage.ref().child('products').child(id!);

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

  List<Map<String, dynamic>> exportSizeList(){
    return sizes!.map((size) => size.toMap()).toList();
  }

  Future<void> save() async{
    loading = true;
    final Map<String, dynamic> data = {
      'name': name,
      'description': description,
      'sizes': exportSizeList(),
    };

    if(id == null){
      final doc = await firestore.collection('products').add(data);
      id = doc.id;
    }else{
      await firestoreRef.update(data);
    }

    final List<String> updateImages = [];

    for(final newImage in newImages!){
      if(images!.contains(newImage)){
        updateImages.add(newImage as String);
      } else {
        final UploadTask task = storageRef.child(Uuid().v1()).putFile(newImage as File); //fazendo o upload
        final TaskSnapshot snapshot = await task; // esperando o upload completar
        final String url = await snapshot.ref.getDownloadURL() as String; // pegando a url do upload
        updateImages.add(url); // adicionando o url no banco de dados
      }
    }

    for (final image in images!){
      if(!newImages!.contains(image)){
        try{
          final ref = storage.refFromURL(image); // buscando images no storage
          await ref.delete();
        }catch(e){
          debugPrint('Falha ao deletar $image');
        }
      }
    }

    await firestoreRef.update({'images': updateImages});

    images = updateImages;

    loading = false;
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
