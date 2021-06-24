import 'package:catalogoapp/helpers/firebase_erros.dart';
import 'package:catalogoapp/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class UserManager{
  
  final FirebaseAuth auth = FirebaseAuth.instance;
  
  Future<void> signIn({
    required UserData user,
    required Function onFail,
    required Function onSuccess
  }) async{
    try {
      // Devoluções = Task de AuthResult com o resultado da operação. Acesso: https://firebase.google.com/docs/reference/android/com/google/firebase/auth/FirebaseAuth#returns_8
      final UserCredential result = await auth.signInWithEmailAndPassword(
          email: user.email,
          password: user.password,
      );
      onSuccess();
    } on FirebaseAuthException catch(e){
      onFail(getErrorString(e.code));
    }
  }
}