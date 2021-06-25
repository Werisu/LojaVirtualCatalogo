import 'package:catalogoapp/helpers/validators.dart';
import 'package:catalogoapp/models/user.dart';
import 'package:catalogoapp/models/user_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  /*
  Quando criamos o formulário, também precisamos fornecer
  uma GlobalKey. Isso identificará de forma exclusiva
  o formulário com o qual estamos trabalhando e
  nos permitirá validar o formulário posteriormente.

  A classe GlobalKey fornece uma chave global única em
  td o aplicativo permitindo identificar de forma exclusiva os elmentos.
   */
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /*
  Para exibir uma Snackbar aquela barra de notificação que aparece
  no app.
  Isso faz mudar o estado do Scaffold.

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  função desatualizada para o flutter 2.2

  usar ScaffoldMessenger.of(context).showSnackBar();
   */
  
  /* O proximo objeto é uma alternativa para o,
  exemplo, final TextEditingController emailController = TextEditingController();
  para pegar valores dos campos
  */
  final UserData user = UserData();

  @override
  Widget build(BuildContext context) {

    // 'RaisedButton' está obsoleto e não deve ser usado. Em vez disso, use ElevatedButton. Consulte o guia de migração em flutter.dev/go/material-button-migration-guide).
    ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: Theme.of(context).primaryColor,
      onSurface: Theme.of(context).primaryColor,
      minimumSize: Size(88, 36),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
      textStyle: TextStyle(fontSize: 18)
    );

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
          },
          icon: Icon(Icons.logout)
          )
        ],
        /*leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () { Navigator.pop(context); },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),*/
        title: const Text("Criar Conta"),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: [
                TextFormField(
                  decoration: const InputDecoration(hintText: "Nome Completo"),
                  validator: (name){
                    if(name!.isEmpty){
                      return "Campo obrigatório";
                    }else if(name.trim().split(' ').length <=1){
                      return "Preencha o nome completo";
                    }else{
                      return null;
                    }
                  },
                  onSaved: (name)=>user.nome = name!,
                ),
                SizedBox(height: 16,),
                TextFormField(
                  decoration: const InputDecoration(hintText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (email){
                    if(email!.isEmpty){
                      return "Campo obrigatório";
                    }else if(!emailValid(email)){
                      return "Email inválido";
                    }else{
                      return null;
                    }
                  },
                  onSaved: (email)=>user.email = email!,
                ),
                SizedBox(height: 16,),
                TextFormField(
                  decoration: const InputDecoration(hintText: "Senha"),
                  obscureText: true,
                  validator: (pass){
                    if(pass!.isEmpty){
                      return "Campo obrigatório";
                    }else if(pass.length < 6){
                      return "Senha muito curta";
                    }else{
                      return null;
                    }
                  },
                  onSaved: (pass)=>user.password = pass!,
                ),
                SizedBox(height: 16,),
                TextFormField(
                  decoration: const InputDecoration(hintText: "Repita a senha"),
                  obscureText: true,
                  validator: (pass){
                    if(pass!.isEmpty){
                      return "Campo obrigatório";
                    }else if(pass.length < 6){
                      return "Senha muito curta";
                    }else{
                      return null;
                    }
                  },
                  onSaved: (pass)=>user.confirmPassword = pass!,
                ),
                SizedBox(height: 16,),
                SizedBox(
                  height: 44,
                  child: TextButton(
                    style: raisedButtonStyle,
                    onPressed: (){
                      if(formKey.currentState!.validate()){
                        formKey.currentState!.save();

                        if(user.password != user.confirmPassword){
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Senha não são identicas"),
                                backgroundColor: Colors.red[900],
                              )
                          );
                          return;
                        }

                        context.read<UserManager>().signUp(
                            user: user,
                            onFail: (e){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(e),
                                    backgroundColor: Colors.red[900],
                                  )
                              );
                            },
                            onSuccess: (){
                              print("suecsso");
                              // TODO: POP
                            }
                        );
                      }
                    },
                    child: Text("Criar Conta"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
