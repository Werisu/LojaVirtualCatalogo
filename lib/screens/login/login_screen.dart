import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // 'RaisedButton' está obsoleto e não deve ser usado. Em vez disso, use ElevatedButton. Consulte o guia de migração em flutter.dev/go/material-button-migration-guide).
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: Theme.of(context).primaryColor,
      minimumSize: Size(88, 36),
      padding: EdgeInsets.all(20),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    );

    // info: 'FlatButton' está obsoleto e não deve ser usado. Em vez disso, use TextButton. Consulte o guia de migração em flutter.dev/go/material-button-migration-guide). Este recurso foi descontinuado após v1.26.0-18.0.pre .. (deprecated_member_use em [catalogoapp] lib \ screens \ login \ login_screen.dart: 54)
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Colors.black87,
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Entrar"),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: "Email"),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                validator: (email){
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(hintText: "Senha"),
                autocorrect: false,
                obscureText: true,
                validator: (pass){
                  if(pass!.isEmpty || pass.length < 6){
                    return 'Senha inválida';
                  }else{
                    return null;
                  }
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  style: flatButtonStyle,
                  onPressed: () {  },
                  child: const Text(
                    "Esqueci minha senha"
                  ),

                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 44,
                child: ElevatedButton(
                  style: raisedButtonStyle,
                  onPressed: (){

                  },
                  child: const Text(
                      "Entrar",
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
