/*
A class User já está em utilização pelo
firebaseAuth, então para não ter conflito
a class User de models foi renomeado
para UserData.
 */
class UserData{

  UserData({this.email = "", this.password = "", this.nome = ""});

  String nome;
  String email;
  String password;
  String confirmPassword = "";


}