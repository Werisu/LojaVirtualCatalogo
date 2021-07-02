import 'package:catalogoapp/models/cart_manager.dart';
import 'package:catalogoapp/models/product-manager.dart';
import 'package:catalogoapp/models/product.dart';
import 'package:catalogoapp/models/user_manager.dart';
import 'package:catalogoapp/screens/base/base_screen.dart';
import 'package:catalogoapp/screens/cart/cart_screen.dart';
import 'package:catalogoapp/screens/login/login_screen.dart';
import 'package:catalogoapp/screens/product/product_screen.dart';
import 'package:catalogoapp/screens/signup/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

  //FirebaseFirestore.instance.collection('teste').add({'teste':'teste'});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_)=>UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_)=>ProductManager(),
          lazy: false,
        ),
        Provider(
          create: (_) => CartManager(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Catálogo Vitual',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Arial',
          primaryColor: const Color.fromARGB(255,184,134,11),
          scaffoldBackgroundColor: const Color.fromARGB(255, 184,134,11),
          appBarTheme: const AppBarTheme(
            elevation: 0
          )
        ),
        initialRoute: '/base',
        onGenerateRoute: (settings){
          switch(settings.name){
            case '/base':
              return MaterialPageRoute(
                builder: (_)=>BaseScreen(),
              );
            case '/login':
              return MaterialPageRoute(
                builder: (_)=>LoginScreen(),
              );
            case '/signup':
              return MaterialPageRoute(
                builder: (_)=>SignUpScreen(),
              );
            case '/product':
              return MaterialPageRoute(
                builder: (_)=>ProductScreen(
                  settings.arguments as Product
                )
              );
            case '/cart':
              return MaterialPageRoute(
                  builder: (_)=>CartScreen()
              );
            default:
              return MaterialPageRoute(
                builder: (_)=>BaseScreen(),
              );
          }
        },
      ),
    );
  }
}