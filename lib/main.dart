import 'package:catalogoapp/models/admin_users_manager.dart';
import 'package:catalogoapp/models/cart_manager.dart';
import 'package:catalogoapp/models/home_manager.dart';
import 'package:catalogoapp/models/product-manager.dart';
import 'package:catalogoapp/models/product.dart';
import 'package:catalogoapp/models/user_manager.dart';
import 'package:catalogoapp/screens/base/base_screen.dart';
import 'package:catalogoapp/screens/cart/cart_screen.dart';
import 'package:catalogoapp/screens/edit_product/edit_product_screen.dart';
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
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
          cartManager!..updateUser(userManager),
        ),
        /// Esse ChangeNotifierProxyProvider é do tipo AdminUsersManager e está vinculado ao UserManager
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
          create: (_) => AdminUsersManager(),
          lazy: true,
          update: (_, userManager, adminUsersManager) =>
          adminUsersManager!..updateUser(userManager),
        )
      ],
      child: MaterialApp(
        title: 'Catálogo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'QuickSand',
          primaryColor: const Color.fromARGB(255,184,134,11),
          scaffoldBackgroundColor: const Color.fromARGB(255, 184,134,11),
          appBarTheme: const AppBarTheme(
            elevation: 0
          ),
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
            case '/edit_product':
              return MaterialPageRoute(
                builder: (_) => EditProductScreen(
                  settings.arguments as Product
                )
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