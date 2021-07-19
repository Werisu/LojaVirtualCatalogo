import 'dart:async';

import 'package:catalogoapp/models/user.dart';
import 'package:catalogoapp/models/user_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AdminUsersManager extends ChangeNotifier {

  List<UserData> users = [];

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  StreamSubscription? _subscription;

  void updateUser(UserManager userManager){
    _subscription?.cancel();
    if(userManager.adminEnabled){
      _listenToUsers();
    } else {
      users.clear();
      notifyListeners();
    }
  }

  void _listenToUsers(){
    firestore.collection('users').get().then((snapshot) {
      users = snapshot.docs.map((d) => UserData.fromDocument(d)).toList();
      users.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      notifyListeners();
    });
  }

  List<String> get names => users.map((e) => e.name).toList();

}

