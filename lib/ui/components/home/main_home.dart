import 'dart:math';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/animations/expandable_fab.dart';
import 'package:jobfuse/ui/floating_action_button/my_floating_button.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import '../../colors/colors.dart';
import '../../message/message.dart';
import '../../proposal_page/proposals.dart';
import '../posts_page/posts.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

int _currentIndex = 0;

var tabs = <Widget>[
  MyHome(),
  Proposals(),
  const Center(
    child: Text('meee'),
  ),
  Chats(),
];
var iconItems = <IconData>[

      Icons.search,


      Icons.fort,


      Icons.search,


      Icons.mail_outline_rounded,



];

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin  {






  String? currentUser = FirebaseAuth.instance.currentUser?.email.toString();
  String? uid = FirebaseAuth.instance.currentUser?.uid.toString();





  @override
  Widget build(BuildContext context) {

    double hieght = MediaQuery.of(context).size.height;




//    LogoutModel logoutModel = LogoutModel();

    return ScaffoldGradientBackground(

      extendBody: true,

      body: tabs[_currentIndex],

      gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.white70,
          ]),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        activeColor: AppColors.logColor,
        gapLocation: GapLocation.center,
        icons: iconItems,
        activeIndex:_currentIndex,
        onTap: (int ) {

          setState(() {

            _currentIndex = int;
          });
        } ,


     ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,


        floatingActionButton:MyFAB(),









    );








  }
}
