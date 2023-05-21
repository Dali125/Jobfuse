//Fix Consistency



import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/ui/colors/colors.dart';
import 'package:jobfuse/ui/components/home/main_home.dart';
import 'package:jobfuse/ui/payments_page/icns/job_fus_icons.dart';
import 'package:jobfuse/ui/payments_page/tabs/home.dart';
import 'package:jobfuse/ui/payments_page/tabs/withdraw.dart';
import 'package:jobfuse/ui/payments_page/tabs/deposit.dart';

class PaymentsHome extends StatefulWidget {
  const PaymentsHome({Key? key}) : super(key: key);

  @override
  State<PaymentsHome> createState() => _PaymentsHomeState();
}

class _PaymentsHomeState extends State<PaymentsHome> {


  int currentIndex = 0;
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();

  List<BottomNavigationBarItem> paymentBar = <BottomNavigationBarItem>[

    const BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: 'Home'),
    const BottomNavigationBarItem(icon: Icon(Icons.download), label: 'Deosit'),
    const BottomNavigationBarItem(icon: Icon(JobFus.exchange), label: 'Transfers'),
    const BottomNavigationBarItem(icon: Icon(JobFus.upload), label: 'Withdraw'),

    
    


  ];
  
  
  List tabs = [
    PayMentHome(uid: FirebaseAuth.instance.currentUser!.uid.toString()),

    const Deposit(),
    Transfer(),
    const Center(child: Text('4'),),

  ];


  var userDetails;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(




      body:  tabs[currentIndex],











      bottomNavigationBar: FadeInUpBig(
        child: BottomNavigationBar(


          currentIndex: currentIndex,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.black,
          selectedItemColor: AppColors.splashColor,
          backgroundColor: AppColors.logColor,
          unselectedLabelStyle: const TextStyle(
            color: Colors.black
          ),
          selectedLabelStyle: const TextStyle(
              color: Colors.black
          ),

          onTap: (index){
            setState(() {
              currentIndex = index;
            });
          },
          items: paymentBar,
          enableFeedback: true,

        ),
      ),
    );
  }
}