import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/constant_widget/card.dart';
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
          stretch: true,
          elevation: 10,
          shadowColor: AppColors.splashColor2,
          expandedHeight: 40,
          title: const Text('Home', style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
          ),),
          // flexibleSpace: const Center(
          //   child: Padding(
          //     padding: EdgeInsets.all(10.0),
          //     child: Text('Money Management',
          //       style: TextStyle(
          //           fontWeight: FontWeight.bold,
          //           fontSize: 20
          //       ),),
          //   ),
          // ),
        ),


        SliverToBoxAdapter(


//This one gets the user details and what not
            child: FutureBuilder(
                future: FirebaseFirestore.instance.collection('users').where('Userid', isEqualTo: widget.uid).get(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {

                    var currentUserDetails = snapshot.data.docs[0];


                    return Padding(
                      padding: EdgeInsets.only(left: 25, right: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          const SizedBox(
                            height: 30,
                          ),

                          Row(
                            children: [

                              FadeInUp(
                                child: Text('${currentUserDetails['First_name']}',
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold
                                ),),


                              ),
                            ],
                          ),

                          const SizedBox(height: 30),

                          const Text('Your Cards',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                            ),),
                          const SizedBox(height: 15,

                          ),


                          DelayedDisplay(
                            delay:Duration(milliseconds: 400),
                            child: FadeInUp(
                              child: FutureBuilder(


                                future: FirebaseFirestore.instance.collection('wallet').where('Userid',
                                    isEqualTo: widget.uid).get(),
                                builder: (context,snapshot) {

                                  var balanceData = snapshot.data?.docs[0];


                                  if(snapshot.hasData) {

                                    return



                                      MyCard();
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
                      ),
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
