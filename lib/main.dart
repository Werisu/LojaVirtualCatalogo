import 'package:catalogoapp/models/user_manager.dart';
import 'package:catalogoapp/screens/base/base_screen.dart';
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
    return ChangeNotifierProvider(
      create: (_) => UserManager(),
      child: MaterialApp(
        title: 'Catálogo Vitual',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 59, 44, 33),
          scaffoldBackgroundColor: const Color.fromARGB(255, 59, 44, 33),
          appBarTheme: const AppBarTheme(
            elevation: 0
          )
        ),
        home: BaseScreen(),
      ),
    );
  }
}