/*
A class User já está em utilização pelo
firebaseAuth, então para não ter conflito
a class User de models foi renomeado
para UserData.
 */
import 'package:cloud_firestore/cloud_firestore.dart';

class UserData{

  UserData({this.email = "", this.password = "", this.name = "", this.id = ""});

  UserData.fromDocument(DocumentSnapshot document){

    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // id = document.documentID;
    id = document.id;
    name = data['name'];
    email = data['email'];
  }

  String id = "";
  String name = "";
  String email = "";
  String password = "";
  String confirmPassword = "";

  // sempre que quiser acessar a referencia do usuário pode usar o firestoreRef
  DocumentReference get firestoreRef => FirebaseFirestore.instance.doc('users/$id');

  CollectionReference get cartReference =>
      firestoreRef.collection('cart');

  Future<void> saveData() async{
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'email': email
    };
  }


}