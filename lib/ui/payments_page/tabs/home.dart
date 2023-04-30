import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/ui/components/ui-rands/text_guides.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../colors/colors.dart';

class PayMentHome extends StatefulWidget {

  final uid;
  const PayMentHome({Key? key, required this.uid}) : super(key: key);

  @override
  State<PayMentHome> createState() => _PayMentHomeState();
}

class _PayMentHomeState extends State<PayMentHome> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return CustomScrollView(

      slivers: [

        SliverAppBar(
          backgroundColor: AppColors.logColor,
          stretch: true,
          elevation: 10,
          shadowColor: AppColors.splashColor2,
          expandedHeight: 120,
          flexibleSpace: const Center(
            child: Text('Money Management',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30
              ),),
          ),
        ),


        SliverToBoxAdapter(


//This one gets the user details and what not
            child: FutureBuilder(
                future: FirebaseFirestore.instance.collection('users').where('Userid', isEqualTo: widget.uid).get(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {

                    var currentUserDetails = snapshot.data.docs[0];


                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        FadeInDown(
                          child: Padding(
                            padding: const EdgeInsets.only(left:20.0, right: 20, top: 40),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.logColor,
                                
                                border: Border.all(width: 1, color: AppColors.splashColor),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Material(
                                color: AppColors.logColor,
                                borderRadius: BorderRadius.circular(10),
                                shadowColor: AppColors.splashColor2,

                                elevation: 20,

                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  child: Container(

                                    width: width,
                                    height: 80,

                                    decoration: BoxDecoration(

                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Column(
                                       crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: FadeInLeft(
                                                child: Text('Hello ${currentUserDetails['First_name']}', style:
                                                const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20
                                                ),),
                                              ),
                                            ),
                                            Center(child: Text(currentUserDetails['UserName'])),
                                          ],
                                        ),
                                        const Expanded(child: SizedBox(width: 500,)),

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),


                        const SizedBox(height: 30),
                        DelayedDisplay(
                          delay:Duration(milliseconds: 400),
                          child: FadeInUp(
                            child: FutureBuilder(


                              future: FirebaseFirestore.instance.collection('wallet').where('Userid',
                                  isEqualTo: widget.uid).get(),
                              builder: (context,snapshot) {

                                var balanceData = snapshot.data!.docs[0];


                                if(snapshot.hasData) {

                                  return Text('Balance  \n  ${balanceData['balance'].toString()}',
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold
                                  ),);
                                }else if(snapshot.connectionState == ConnectionState.waiting)
                                {
                                  return const Text('Loading');
                                }else{
                                  return CircularProgressIndicator();
                                }
                              }
                            ),
                          ),
                        )
                        //This one is getting the Balance, which can be increased or decreased

                      ],
                    );
                  }
                  else if (snapshot.hasError) {
                    return Icon(Icons.error_outline);
                  }

                  else {
                    return CircularProgressIndicator();
                  }
                }))
      ]

    ,);

  }
}
