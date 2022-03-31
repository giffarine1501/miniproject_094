import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/pages/HomPage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rabbit Rabbit',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        textTheme: GoogleFonts.baiJamjureeTextTheme()
      ),
      home: const HomePage(),
    );
  }
}

