import 'package:catalogoapp/models/section.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class HomeManager extends ChangeNotifier{

  HomeManager(){
    _loadSections();
  }

  List<Section> _sections = [];

  /// clonando
  List<Section> _editingSections = [];

  bool editing = false;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> _loadSections() async{
    // modificação na tela do gerente aparecerá instataneamente na tela
    // do cliente
    firestore.collection('home').snapshots().listen((snapshot) {
      _sections.clear();
      for(final DocumentSnapshot document in snapshot.docs){
        _sections.add(Section.fromDocument(document));
      }
      notifyListeners();
    });
  }

  void addSection(Section section){
    _editingSections.add(section);
    notifyListeners();
  }

  List<Section> get sections{
    if(editing){
      return _editingSections;
    }else{
      return _sections;
    }
  }

  void removeSection(Section section){
    _editingSections.remove(section);
    notifyListeners();
  }

  void enterEditing(){
    editing = true;

    _editingSections = _sections.map((s) => s.clone()).toList();

    notifyListeners();
  }

  void saveEditing(){
    bool valid = true;

    for(final section in _editingSections){
      if(!section.valid()) valid = false;
    }

    if(!valid) return;

    print("salver");

    // TODO: SALVAMENTO

    /*editing = false;
    notifyListeners();*/
  }

  void discardEditing(){
    editing = false;
    notifyListeners();
  }

}