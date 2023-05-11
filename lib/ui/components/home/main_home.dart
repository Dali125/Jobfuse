import 'dart:math';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/ui/components/posts_page/main_posts.dart';
import 'package:jobfuse/ui/contracts/contracts_page.dart';
import 'package:jobfuse/ui/floating_action_button/my_floating_button.dart';
import '../../colors/colors.dart';
import '../../message/message.dart';
import '../../proposal_page/proposals.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

int _currentIndex = 0;

var tabs = <Widget>[
  const JobsHome(),
 // Center(child: Text('2'),),
  const Proposals(),
  const ContractsPage(),
  const Chats(),
];


var IconItems = <IconData>[

  Icons.home_outlined,
  Icons.abc_sharp,
  Icons.close,
  Icons.message_outlined,


];

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin  {






  String? currentUser = FirebaseAuth.instance.currentUser?.email.toString();
  String? uid = FirebaseAuth.instance.currentUser?.uid.toString();


  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }
    (context as Element).visitChildren(rebuild);
  }



  @override
  Widget build(BuildContext context) {
    rebuildAllChildren(context);

    double hieght = MediaQuery.of(context).size.height;





    return Scaffold(



      body: tabs[_currentIndex],
      bottomNavigationBar: AnimatedBottomNavigationBar(
        backgroundColor: AppColors.logColor,
        splashColor: Colors.orangeAccent,
        activeColor: AppColors.splashColor,
        gapLocation: GapLocation.center,
        icons: IconItems,
        elevation: 10,
        activeIndex: _currentIndex, onTap: (int ) {


          setState(() {
            _currentIndex = int;
          });
      },


      ),


      floatingActionButton: const MyFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,


    );






  }
}
