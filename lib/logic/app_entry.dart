import 'package:flutter/material.dart';

import '../ui/components/splash_screen/splash.dart';

class appEntry extends StatelessWidget {
  const appEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(





      debugShowCheckedModeBanner: false,





      home: SplashScreen(),
    );
  }
}
