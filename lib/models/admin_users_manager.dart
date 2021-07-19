import 'package:catalogoapp/models/user.dart';
import 'package:catalogoapp/models/user_manager.dart';
import 'package:faker/faker.dart';
import 'package:flutter/cupertino.dart';

class AdminUsersManager extends ChangeNotifier {

  List<UserData> users = [];

  void updateUser(UserManager userManager){
    if(userManager.adminEnabled){
      _listenToUsers();
    }
  }

  void _listenToUsers(){
    const faker = Faker();

    for(int i=0; i < 100; i++){
      users.add(
          UserData(
              name: faker.person.name(),
              email: faker.internet.email()
          )
      );
    }

    users.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    notifyListeners();
  }

  List<String> get names => users.map((e) => e.name).toList();

}

