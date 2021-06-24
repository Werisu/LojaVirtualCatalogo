import 'package:catalogoapp/screens/base/base_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

  //FirebaseFirestore.instance.collection('teste').add({'teste':'teste'});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}