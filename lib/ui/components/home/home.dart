
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../login/login.dart';
import 'main_home.dart';




class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          useMaterial3: true
      ),
      initialRoute:
      FirebaseAuth.instance.currentUser == null ? 'login' : 'home',

      routes: {

        'login' : (context) => const Login(),
        'home' : (context) => const MainPage(),
      },
    );
  }
}
