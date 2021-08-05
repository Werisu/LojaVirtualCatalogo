import 'dart:io';

import 'package:catalogoapp/models/section_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class Section extends ChangeNotifier {

  Section({this.id, this.name, this.type, this.items}){
    items = items ?? [];
    originalItems = List.from(items!);
  }

  Section.fromDocument(DocumentSnapshot document){
    id = document.id;
    name = document.get('name') as String;
    type = document.get('type') as String;
    items = (document.get('items') as List).map(
            (i) => SectionItem.fromMap(i as Map<String, dynamic>)).toList();
  }

  String? id;
  String? name;
  String? type;
  List<SectionItem>? items;

  // save
  List<SectionItem>? originalItems;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  DocumentReference get firestoreRef => firestore.doc('home/$id');
  Reference get storageRef => storage.ref().child('home/$id');

  String? _error;
  String? get error => _error;
  set error(String? value){
    _error = value;
    notifyListeners();
  }

  void addItem(SectionItem item){
    items!.add(item);
    notifyListeners();
  }

  void removeItem(SectionItem item){
    items!.remove(item);
    notifyListeners();
  }

  Future<void> save() async{
    loading = true;
    final Map<String, dynamic> data = {
      'name' : name,
      'type' : type,
    };

    if(id == null){
      final doc = await firestore.collection('home').add(data);
      id = doc.id;
    }else{
      await firestoreRef.update(data);
    }

    for(final item in items!){
      if(item.image is File){
        final UploadTask task = storageRef.child(Uuid().v1())
            .putFile(item.image as File);
        final TaskSnapshot snapshot = await task.whenComplete((){
          print("Upload de seções imagens realizada com sucesso");
        });
        final String url = await snapshot.ref.getDownloadURL() as String;
        item.image = url;
      }
    }

    for(final original in originalItems!){
      if(!items!.contains(original)){
        try{
          final ref = storage.refFromURL(
              original.image as String
          );
          await ref.delete();
        }catch (e){}
      }
    }

    final Map<String, dynamic> itemsData = {
      'items' : items!.map((e) => e.toMap()).toList()
    };
    
    await firestoreRef.update(itemsData);

    loading = false;
  }

  bool valid(){
    if(name == null || name!.isEmpty){
      error = "Título inválido";
    }else if(items!.isEmpty){
      error = "Insira ao menos uma imagem";
    } else {
      error = null;
    }
    return error == null;
  }

  Section clone(){
    return Section(
      id: id,
      name: name,
      type: type,
      items: items!.map((e) => e.clone()).toList()
    );
  }

  @override
  String toString() {
    return 'Section{name: $name, type: $type, items: $items}';
  }
}