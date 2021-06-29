import 'package:catalogoapp/models/user_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
      height: 150,
      child: Consumer<UserManager>(
        builder: (_, userManager, __){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Luah's",
                style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                'Olá, ${userManager.user.name}',
                overflow: TextOverflow.ellipsis, //se o nome for muito grande ele n vai sair da linha
                maxLines: 2,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),
              ),
              GestureDetector(
                onTap: (){
                  //FirebaseAuth.instance.signOut();
                  if(userManager.isLoggedIn){
                    userManager.signOut();
                    Navigator.of(context).pushNamed('/home');
                    /// snackbar personalizada
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Você deslogou do app"),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      )
                    );
                  }else{
                    Navigator.of(context).pushNamed('/login');
                  }
                },
                child: Text(
                  userManager.isLoggedIn
                      ? "Sair"
                      : "Entre ou cadastre-se",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
              )
            ],
          );
        },
      )
      );
  }
}
