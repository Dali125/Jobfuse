
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jobfuse/ui/personal_info_page/update_info.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:shimmer_animation/shimmer_animation.dart';


import '../colors/colors.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  final storageRef = FirebaseStorage.instance.ref();



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.width;
    double titleFontsize = 20;


    return Scaffold(


    body: CustomScrollView(


      slivers: [
        SliverAppBar(


          backgroundColor: AppColors.logColor,
          expandedHeight: 80,
          flexibleSpace: const Center(
            child: Text('My Info', style: TextStyle(
              fontSize: 30
            ),
            ),
          ),
        ),
        SliverToBoxAdapter(

          child: StreamBuilder(stream: FirebaseFirestore.instance.collection('users')
           .where('Userid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots()
            ,builder: (context, snapshot){

            if(snapshot.hasData){


              return Container(
                height: height*5,
                width: width,
                child: ListView.builder(itemCount: snapshot.data?.docs.length
                    ,itemBuilder: (context, index){

                  var userData = snapshot.data!.docs[index];


                  return DelayedDisplay(child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,


                      children: [

                        const SizedBox(
                          height: 30,
                        ),

                        Container(
                          width: width,

                          decoration:BoxDecoration(

                              border: Border.all(color: AppColors.splashColor),
                              borderRadius: BorderRadius.circular(5)
                          ),child: Column(children: [

                          Text('UserName',style: TextStyle(fontSize: titleFontsize,fontWeight: FontWeight.bold),),
                          Text(userData['UserName'],style: TextStyle(fontSize: 20),),

                        ],),),

                        const SizedBox(height: 10,),


                        Container(
                          width: width,

                          decoration:BoxDecoration(

                          border: Border.all(color: AppColors.splashColor),
                            borderRadius: BorderRadius.circular(5)
                        ),child: Column(children: [

                          Text('First Name',style: TextStyle(fontSize: titleFontsize,fontWeight: FontWeight.bold),),
                          Text(userData['First_name'],style: TextStyle(fontSize: 20),),

                        ],),),

                        const SizedBox(height: 10,),
                        Container(
                          width: width,

                          decoration:BoxDecoration(

                              border: Border.all(color: AppColors.splashColor),
                              borderRadius: BorderRadius.circular(5)
                          ),child: Column(children: [

                          Text('Last Name',style: TextStyle(fontSize: titleFontsize,fontWeight: FontWeight.bold),),
                          Text(userData['Last_name'],style: TextStyle(fontSize: 14),),

                        ],),),

                        const SizedBox(height: 10,),
                        Container(
                          width: width,

                          decoration:BoxDecoration(

                              border: Border.all(color: AppColors.splashColor),
                              borderRadius: BorderRadius.circular(5)
                          ),child: Column(children: [

                          Text('Phone Number',style: TextStyle(fontSize: titleFontsize,fontWeight: FontWeight.bold),),
                          Text(userData['Phone_Number'].toString(),style: TextStyle(fontSize: 14),),

                        ],),),

                        const SizedBox(height: 10,),
                        Container(
                          width: width,

                          decoration:BoxDecoration(

                              border: Border.all(color: AppColors.splashColor),
                              borderRadius: BorderRadius.circular(5)
                          ),child: Column(children: [

                          Text('NRC/ID NUMBER',style: TextStyle(fontSize: titleFontsize,fontWeight: FontWeight.bold),),
                          Text(userData['NRC_NUMBER'],style: TextStyle(fontSize: 14),),

                        ],),),

                        const SizedBox(height: 10,),
                        Container(
                          width: width,

                          decoration:BoxDecoration(

                              border: Border.all(color: AppColors.splashColor),
                              borderRadius: BorderRadius.circular(5)
                          ),child: Column(children: [

                          Text('Email',style: TextStyle(fontSize: titleFontsize,fontWeight: FontWeight.bold),),
                          Text(FirebaseAuth.instance.currentUser!.email.toString(),style: TextStyle(fontSize: 14),),

                        ],),),
                        const SizedBox(height: 10,),


                        GestureDetector(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(40, 10, 40, 10),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.logColor,
                              ),

                              width: width,
                              height: 60,
                              child: const Center(
                                child: Text('Update Details',
                                style: TextStyle(fontSize: 24),),

                              ),
                            ),
                          ),
                          onTap: (){


                            Navigator.push(context, PageTransition(child: UpdateInfo(data: userData), type: PageTransitionType.bottomToTop));
                          },
                        )






                      ],

                    ),
                  ));



                }),
              );
            }else {
              return Column(

              children: [

                Shimmer(child: Container(
                  width: width,
                )),
                Shimmer(child: Container(
                  width: width,
                )),
                Shimmer(child: Container(
                  width: width,
                )),
                Shimmer(child: Container(
                  width: width,
                )),
              ],
            );
            }




          },





          )
        )
      ],
    ),




    );
  }
}
