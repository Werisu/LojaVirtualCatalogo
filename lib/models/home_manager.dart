import 'package:catalogoapp/models/section.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class HomeManager {

  HomeManager(){
    _loadSections();
  }

  List<Section> sections = [];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _loadSections() async{
    // modificação na tela do gerente aparecerá instataneamente na tela
    // do cliente
    firestore.collection('home').snapshots().listen((snapshot) {
      sections.clear();
      for(final DocumentSnapshot document in snapshot.docs){
        sections.add(Section.fromDocument(document));
      }
      print(sections);
    });
  }

}