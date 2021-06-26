import 'package:catalogoapp/helpers/firebase_erros.dart';
import 'package:catalogoapp/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserManager extends ChangeNotifier{

  UserManager(){
    _loadCurrentUser();
  }
  
  final FirebaseAuth auth = FirebaseAuth.instance;
  late final User user;

  bool _loading = false;
  bool get loading => _loading;
  
  Future<void> signIn({
    required UserData user,
    required Function onFail,
    required Function onSuccess
  }) async{
    loading = true;
    try {
      // Devoluções = Task de AuthResult com o resultado da operação. Acesso: https://firebase.google.com/docs/reference/android/com/google/firebase/auth/FirebaseAuth#returns_8
      final UserCredential result = await auth.signInWithEmailAndPassword(
          email: user.email,
          password: user.password,
      );

      this.user = result.user!;

      onSuccess();
    } on FirebaseAuthException catch(e){
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  Future<void> signUp({
      required UserData user,
      required Function onFail,
      required Function onSuccess
  }) async{
    loading = true;
    try{
      final UserCredential result = await auth.createUserWithEmailAndPassword(email: user.email, password: user.password);

      user.id = result.user!.uid;

      await user.saveData();

      onSuccess();
    } on FirebaseException catch(e){
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  set loading(bool value){
    _loading = value;
    notifyListeners();
  }

  void _loadCurrentUser() async{
    final User? currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser != null){
      user = currentUser;
      print("uid: "+user.uid);
    }
    notifyListeners();
  }
}