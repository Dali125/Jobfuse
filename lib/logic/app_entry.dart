import 'package:flutter/material.dart';

import '../ui/components/splash_screen/splash.dart';

class appEntry extends StatelessWidget {
  const appEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,

      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,

      ),
      themeMode: ThemeMode.system,


      debugShowCheckedModeBanner: false,



      home: SplashScreen(),
    );
  }
}
