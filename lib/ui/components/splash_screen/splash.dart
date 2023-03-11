import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/ui/colors/colors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rive/rive.dart';

import '../home/home.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    //Screen Sizes
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;
    
    //CurrentUser
    return AnimatedSplashScreen(
        backgroundColor: Color(0xFFE0E0E0),
        splash: Container(height: height,width: width,
        child: Stack(children: [RiveAnimation.asset('assets/jobfuse6.riv',)]),),
        animationDuration: const Duration(milliseconds: 3800),
        pageTransitionType: PageTransitionType.fade,
        splashIconSize: height,
        nextScreen: const Home());
  }
}
