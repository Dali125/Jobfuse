import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/constant_widget/confirm_hire.dart';
import 'package:jobfuse/ui/colors/colors.dart';
import 'package:jobfuse/ui/components/ui-rands/my_button.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ReceivedBlock extends StatefulWidget {
  final String freelanceID;
  final String remarks;
  final String proposalsID;
  const ReceivedBlock({Key? key,required this.freelanceID, required this.remarks, required this.proposalsID}) : super(key: key);

  @override
  State<ReceivedBlock> createState() => _ReceivedBlockState();
}

class _ReceivedBlockState extends State<ReceivedBlock> {






  @override
  void initState(){

    super.initState();



  }

  @override
  Widget build(BuildContext context) {



    double width = MediaQuery.of(context).size.width;
    return

      FutureBuilder(
          future: FirebaseFirestore.instance.collection('users').where('Userid', isEqualTo: widget.freelanceID).get(),
          builder: (context, snapshot){

            var userData = snapshot.data?.docs[0];

            if(snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Material(

                elevation: 15,
                shadowColor: AppColors.splashColor2,
                borderRadius: BorderRadius.circular(15),
                color: AppColors.logColor,
                child: Container(


                  decoration: BoxDecoration(

                    border: Border.all(

                    color: AppColors.splashColor2,
                        style: BorderStyle.solid
                  )
                    , borderRadius: BorderRadius.circular(15)



                    ,),
                  height: 450,
                  width: width,
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.freelanceID),
                      FadeInUp(
                        delay: const Duration(milliseconds: 400),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            height: 100,
                            width: width,
                            child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Center(child: Text('From ${userData?['UserName']}',

                                  style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.splashColor2,
                                      fontSize: 14
                                ),)),


                                const Expanded(
                                    child: SizedBox(
                                      width: 50,
                                    )
                                ),

                                SizedBox(
                                  width: 50,
                                  child: Column(
                                    children: [

                                      IconButton(onPressed: (){

                                      }, icon: const Icon(Icons.person)),
                                      const Text('Profile')
                                    ],
                                  ),
                                )
                              ],
                            ),

                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 120,
                          width: width,

                          child:
                          Padding(

                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              children: [
                                FadeInLeft(
                                    delay: const Duration(milliseconds: 600),
                                    child: SizedBox(
                                        height: 200,
                                        child: Text(widget.remarks))),
                                SizedBox(
                                  width: width,
                                  height: 70,
                                  child: Row(
                                    children: [

                                      FadeInLeft(

                                        delay: const Duration(milliseconds: 800),
                                        child: MyButton(onTap: () {


                                          showDialog(context: context, builder: (context) =>

                                          ConfirmHire(clientId: FirebaseAuth.instance.currentUser!.uid.toString(), freelanceId: widget.freelanceID, proposalsID: widget.proposalsID)
                                          );




                                        }, buttonText: 'Hire    '
                                        ),
                                      ),
                                      FadeInRight(child: MyButton(onTap: () {}, buttonText: 'Message')),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      ,const SizedBox(height: 30,)


                    ],
                  ),
                ),
              ),
            );
          }else {
            return Shimmer(
              color: AppColors.logColor,

              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(

                  height: 300,
                ),
              ),
            );
          }

      });
  }
}
