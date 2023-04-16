import 'package:cloud_firestore/cloud_firestore.dart';
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
          shadowColor: Colors.black87,
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
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(left:20.0, right: 20, top: 40),
                          child: Container(
                            decoration: BoxDecoration(
                              
                              border: Border.all(width: 1, color: AppColors.splashColor),
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Material(
                              borderRadius: BorderRadius.circular(10),

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
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Hello ${currentUserDetails['First_name']}', style:
                                          const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20
                                          ),),
                                          Text(currentUserDetails['UserName']),
                                        ],
                                      ),
                                      const Expanded(child: SizedBox(width: 500,)),
                                      // FutureBuilder(
                                      //     future: FirebaseFirestore.instance.collection('wallet').where('balance', isEqualTo: 5000).get(),
                                      //     builder: (BuildContext context,
                                      //         AsyncSnapshot snapshot2) {
                                      //       if (snapshot2.hasData) {
                                      //
                                      //         var walletBalance = snapshot2.data.docs[0];
                                      //         return Expanded(
                                      //           child: Container(
                                      //             width: 60,
                                      //             child: Column(
                                      //               children: [
                                      //                 TextGuide(fontSize: 20, text: 'Balance', padding: 1,),
                                      //                 Text(walletBalance['balance'].toString()),
                                      //               ],
                                      //             ),
                                      //           ),
                                      //         );
                                      //       } else if (snapshot2.hasError) {
                                      //         return Icon(Icons.error_outline);
                                      //       } else {
                                      //         return Shimmer(child:  const SizedBox(
                                      //           height: 20,
                                      //           width: 30,
                                      //         ));
                                      //       }
                                      //     }),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),


                        //This one is getting the Balance, which can be increased or decreased

                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Icon(Icons.error_outline);
                  } else {
                    return CircularProgressIndicator();
                  }
                }))
      ]

    ,);

  }
}
