//Tasks for the week======================================
//Getting the current user,or the client
//Searching for the person who applied in the users database
//Getting their details
// Now, we style the ui

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/ui/proposal_page/recieved_proposal_block.dart';

import 'package:shimmer_animation/shimmer_animation.dart';

import '../colors/colors.dart';





class ReceivedProposal extends StatefulWidget {
  const ReceivedProposal({Key? key}) : super(key: key);

  @override
  State<ReceivedProposal> createState() => _ReceivedProposalState();
}

class _ReceivedProposalState extends State<ReceivedProposal> {

  //The Users Current userID;
  String myID = FirebaseAuth.instance.currentUser!.uid.toString();
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    return
        StreamBuilder(//Getting all proposals sent to this user
            stream: FirebaseFirestore.instance.collection('proposals').
            where('client_id', isEqualTo: myID).snapshots(),
            builder: (context, snapshot){

             


              //if snapshot contains the data, execute
              if(snapshot.hasData){


                return FutureBuilder(
                    future: FirebaseFirestore.instance.collection('proposals').
                    where('client_id', isEqualTo: myID).get(),
                    builder: (context, snapshot){

                   if(snapshot.hasData){

                     return ListView.separated(
                         itemCount: snapshot.data!.docs.length,
                         itemBuilder: (context, index){


                           var otherUser = snapshot.data!.docs[index];
                           String freelanceID = otherUser['freelance_id'];

                           return ReceivedBlock(freelanceID: freelanceID,);




                     }, separatorBuilder: (BuildContext context, int index) {
                           return const SizedBox(
                             height: 30,
                           );
                     },);





                   }else{


                     return const Text('Nothing to show here');


                   }






                });




              }else{

                return Shimmer(child: SizedBox(
                  width: width,
                  height: 400,

                ));
              }





        });


  }
}
