import 'package:catalogoapp/helpers/firebase_erros.dart';
import 'package:catalogoapp/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserManager extends ChangeNotifier{
  
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool loading = false;
  
  Future<void> signIn({
    required UserData user,
    required Function onFail,
    required Function onSuccess
  }) async{
    setLoading(true);
    try {
      // Devoluções = Task de AuthResult com o resultado da operação. Acesso: https://firebase.google.com/docs/reference/android/com/google/firebase/auth/FirebaseAuth#returns_8
      final UserCredential result = await auth.signInWithEmailAndPassword(
          email: user.email,
          password: user.password,
      );

      await Future.delayed(Duration(seconds: 4));

      onSuccess();
    } on FirebaseAuthException catch(e){
      onFail(getErrorString(e.code));
    }
    setLoading(false);
  }

  void setLoading(bool value){
    loading = value;
    notifyListeners();
  }
}