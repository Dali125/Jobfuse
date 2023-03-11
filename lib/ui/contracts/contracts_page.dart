import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/ui/colors/colors.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ContractsPage extends StatefulWidget {
  const ContractsPage({Key? key}) : super(key: key);

  @override
  State<ContractsPage> createState() => _ContractsPageState();
}

class _ContractsPageState extends State<ContractsPage> {




  String currentUser = FirebaseAuth.instance.currentUser!.uid.toString();
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(



      body: CustomScrollView(


        slivers: [
          const SliverAppBar(
            title: Text('Contracts'),
            expandedHeight: 120,
          ),

          SliverToBoxAdapter(

            child: SizedBox(
              height: height,
              width: width,


              child: Row(
                children: [

                  //This Stream Builder is just going to Filter out the Contracts that
                  //belong to The involved Parties
                  //More Components to be added soon, so Currently ,
                  //It will be a vertical list
                  StreamBuilder(

                    //Dont Forget to Change the database here
                      stream: FirebaseFirestore.instance.collection('co').where(
                      'involvedParties', arrayContains: currentUser).snapshots(),
                      builder: (context, snapshot){


                        if(snapshot.hasData){


                          return ListView.builder(



                            scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index){

                                var data = snapshot.data!.docs[index];


                          return const Placeholder();



                          });




                        }else {



                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Shimmer(child: Container(

                              height: 50,
                              width: width,
                              color: AppColors.logColor,


                            )),
                          );
                        }



                  }),
                ],
              ),
            ),
          )
        ],
      ),


    );
  }
}
