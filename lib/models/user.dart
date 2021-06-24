/*
A class User já está em utilização pelo
firebaseAuth, então para não ter conflito
a class User de models foi renomeado
para UserData.
 */
class UserData{

  UserData({required this.email, required this.password});

  late String email;
  late String password;



}