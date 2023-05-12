import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/ui/proposal_page/submit_proposal_block.dart';

class SubmittedProposals extends StatefulWidget {
  const SubmittedProposals({Key? key}) : super(key: key);

  @override
  State<SubmittedProposals> createState() => _SubmittedProposalsState();
}

class _SubmittedProposalsState extends State<SubmittedProposals> {


  String currentUser = FirebaseAuth.instance.currentUser!.uid.toString();

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: width,
      child: FutureBuilder(
        future: FirebaseFirestore.instance.collection('proposals').
        where('freelance_id',isEqualTo: currentUser).get(),
        builder: (context, snapshot){
          if(snapshot.hasData){





            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index){

                  var otherUser = snapshot.data!.docs[index];
                  String document_id = otherUser['document_id'];
                  String remarks = otherUser['remarks'];
                  String proposalsID = otherUser['proposal_id'];
                  String client = otherUser['client_id'];

                  return SubmittedProposalBlock(freelanceID: client, remarks: remarks, proposalsID: proposalsID, documentID: document_id,);



            });
          }else{

            return SizedBox(
              height: height,
              width: width,
              child: const Center(

                child: CircularProgressIndicator(),
              ),
            );
          }





        },
      ),




    );
  }




  void isProposalAccepted() async{
    final snapshot =
        await FirebaseFirestore.instance.collection('proposals');



  }
}
