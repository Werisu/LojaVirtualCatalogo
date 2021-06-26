import 'package:catalogoapp/helpers/firebase_erros.dart';
import 'package:catalogoapp/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

/// classe para gerenciar usuários
class UserManager extends ChangeNotifier{

  UserManager(){
    // entrou no app !!!
    // chama o _loadCurrentUser
    _loadCurrentUser();
  }
  
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  UserData user = UserData();

  bool _loading = false;
  bool get loading => _loading;

  bool get isLoggedIn => user != null;
  
  Future<void> signIn({
    required UserData user,
    required Function onFail,
    required Function onSuccess
  }) async{
    loading = true;
    try {
      // fez login Sucesso !!!
      // Devoluções = Task de AuthResult com o resultado da operação. Acesso: https://firebase.google.com/docs/reference/android/com/google/firebase/auth/FirebaseAuth#returns_8
      // pega usuário do firebase (result)
      final UserCredential result = await auth.signInWithEmailAndPassword(
          email: user.email,
          password: user.password,
      );

      //manda para o _loadCurrentUser(result para _loadCurrentUser)
      await _loadCurrentUser(firebaseUser: result.user);

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
      this.user = user;

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

  /// _loadCurrentUser(User?): função para carregar usuário ou fazer login
  /// o user pode ser nulo, ou seja, não estar logado ou pode vim com
  /// usuário. Se vinher nulo significa que o usuário não está logado no app
  /// se vinher com dados significa que usuário está logado
  Future<void> _loadCurrentUser({User? firebaseUser}) async{
    final User? currentUser = firebaseUser ?? FirebaseAuth.instance.currentUser;
    /// se usuário for diferente de nulo
    if(currentUser != null){
      /// acessando a coleção users, pegando o uid do usuário que está logado no momento
      /// e dando um get para obter p documento
      final DocumentSnapshot docUser = await firestore.collection('users').doc(currentUser.uid).get();

      /// obter os dados do usuário logado
      user = UserData.fromDocument(docUser);
      print(user.name);
      notifyListeners();
    }
  }
}