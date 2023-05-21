//So, the contracts section will involve two or more users.
//This means that the users will be stored in an array
//So the order of precedence is that the first value in the array
//Will be the owner of the project, and the clients will follow
//Afterwards



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:jobfuse/ui/colors/colors.dart';
import 'package:jobfuse/ui/components/ui-rands/text_guides.dart';
import 'package:jobfuse/ui/components/ui-rands/text_title.dart';
import 'package:jobfuse/ui/payments_page/tabs/withdraw.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import 'contracts_block.dart';
class ContractsPage extends StatefulWidget {
  const ContractsPage({Key? key}) : super(key: key);

  @override
  State<ContractsPage> createState() => _ContractsPageState();
}

class _ContractsPageState extends State<ContractsPage> {


  String myUserID = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(



      body: CustomScrollView(

        slivers: [

          SliverAppBar(
            expandedHeight: 120,
            stretch: true,
            elevation: 10,
            backgroundColor: AppColors.logColor,

            flexibleSpace: const Center(
              child: Text('Contracts', style: TextStyle(
                fontSize: 30
              ),),
            ),
          ),
          SliverToBoxAdapter(




            child: Container(
              height: height,
              width: width,


              child: StreamBuilder(
                //The array contains 2 values, where the people who had agreed to the task are kept
                stream: FirebaseFirestore.instance.collection('contracts').
                where('involvedParties',arrayContains: myUserID).snapshots(),
                builder: (context, snapshot){



                  if(snapshot.hasData){


                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index){

                          //The info about the contract
                      var contractInfo = snapshot.data!.docs[index];

                      //A list of both users, or all of the users in the contract
                      List otherUser = contractInfo['involvedParties'];

                      String firstInArray = otherUser[0];
                      otherUser.remove(myUserID);

                      //The ID of the other user
                      String otherUserString = otherUser[0].toString();



                      return  Slidable(




                        key: const ValueKey(0),
                        startActionPane: ActionPane(
                          extentRatio: 0.7,

                          motion: const ScrollMotion(),
                          // dismissible: DismissiblePane(onDismissed: (){}
                          //
                          //   ,),

                          children: [

                            SlidableAction(onPressed: (context){

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Terminate'),
                                    content: const Text('Terminate Contract, this action cannot be undone ?'),
                                    actions: <Widget>[
                                      TextButton(onPressed: ()async{





                                        Navigator.of(context).pop();

                                      }, child: const Text('Yes', style: TextStyle(color: Colors.green),)),

                                      TextButton(
                                        onPressed: () {


                                        },


                                        child: const Text('No', style: TextStyle(color: Colors.red),),
                                      ),
                                    ],
                                  );
                                },
                              );


                            },
                              backgroundColor: const Color(0xFFFE4a49),
                              icon: Icons.cancel_presentation_rounded,
                              label: 'Terminate',
                              flex: 2,
                            ),
                            SlidableAction(onPressed: (context){

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Payout'),
                                    content: const Text('Proceed to payment?'),
                                    actions: <Widget>[
                                      TextButton(onPressed: ()async{





                                        Navigator.of(context).pop();
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Transfer()));

                                      }, child: const Text('Yes', style: TextStyle(color: Colors.green),)),

                                      TextButton(
                                        onPressed: () {


                                        },


                                        child: const Text('No', style: TextStyle(color: Colors.red),),
                                      ),
                                    ],
                                  );
                                },
                              );


                            },
                              backgroundColor: Colors.green,
                              icon: Icons.monetization_on_outlined,
                              label: 'Payout',
                              flex: 2,
                            ),




                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Material(
                            borderRadius: BorderRadius.circular(20),
                            elevation: 10,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: (){


                              },
                              //To kind of get the size of the container, which contains contract details
                              child: Container(
                                height: width < 600 ? 180 : 300,
                                width: width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.black
                                  )
                                ),

                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: FutureBuilder(
                                    //Getting document id, and all Data associated
                                    future: FirebaseFirestore.instance.collection('ProjectTasks').
                                    doc(contractInfo['projectID']).get(),
                                    builder: (context, snapshot){


                                      if (snapshot.connectionState == ConnectionState.done){

                                        //The data of the project transformed to a map
                                        Map<String, dynamic> data =
                                        snapshot.data!.data() as Map<String, dynamic>;

                                      //Info to put on the Contract
       //**********************************************************************************

                                        //Status of the contract
                                        String status = contractInfo['status'];

                                        //Begin Date of the Contract


                                        var begindate = contractInfo['BeginDate'];

                                        DateTime dateTime = begindate.toDate();
                                        String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
                                        //Title of the contract
                                        String title = data['title'];

                                        //Require level of the contract
                                        String experienceLevel = data['ExperienceLevel'];

                                        //duration of the contract
                                        String contractDuration = data['ExperienceLevel'];

                                        //Budget of the contract
                                        int Budget = data['Budget'];


//*******************************************************************************************


                                        return FutureBuilder(


                                        future: FirebaseFirestore.instance.collection('users').
                                            where('Userid',isEqualTo: firstInArray).get(),

                                        builder: (context, snapshot){

                                        if(snapshot.hasData){



                                          var contractUserdata = snapshot.data?.docs[0];

                                          return InkWell(
                                            onTap: (){



                                              //To view more Details about the Contract here
                                              Navigator.push(context, PageTransition(
                                                  alignment: Alignment.center,
                                                  child: ExpandedContract(contractInfo: title,
                                                    currentUser: myUserID,
                                                    otherUser: otherUserString,
                                                    status: status,
                                                    begindate: formattedDateTime,
                                                    experienceLevel: experienceLevel,
                                                    contractDuration: contractDuration,
                                                    Budget: Budget, projectOwnerName: '${contractUserdata?['First_name']} ${contractUserdata?['Last_name']}',





                                                  ),
                                                  type: PageTransitionType.scale));
                                            },
                                            child: DelayedDisplay(
                                              delay: const Duration(milliseconds: 200),
                                              child:
                                              //The Summary of the Contract
                                              Padding(padding: const EdgeInsets.only(left: 10, right: 10, top: 10)

                                                ,child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(

                                                      crossAxisAlignment: CrossAxisAlignment.start,

                                                      children: [
                                                        Column(

                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [

                                                            TextTitle(fontSize: 20, text: 'Project Owner ', padding: 1, fontWeight: FontWeight.bold,),
                                                            Text('${contractUserdata?['First_name']} ${contractUserdata?['Last_name']}'),
                                                            SizedBox(height: 10,),

                                                          ],
                                                        ),





                                                        Expanded(child: Container(
                                                          width: width,

                                                        )),

                                                        SizedBox(height: 10,),
                                                        Expanded(
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,

                                                            children: [

                                                              TextTitle(fontSize: width < 600 ? 14 : 20, text: 'Project Status',
                                                                padding: 1, fontWeight: FontWeight.bold,),
                                                              Text(contractInfo['status'], style: TextStyle(fontSize: 10,
                                                                  color: contractInfo['status'] == 'ongoing' ? Colors.green : Colors.red


                                                              ),),

                                                            ],),
                                                        )



                                                      ],
                                                    ),


                                                    TextTitle(fontSize: 20, text: 'ProjectTitle ', padding: 1, fontWeight: FontWeight.bold,),
                                                            Text(data['title']),
                                                            SizedBox(height: 10,),
                                                  ],
                                                ),


                                              ),
                                            ),
                                          );
                                        }else if(snapshot.connectionState == ConnectionState.waiting){

                                          return CircularProgressIndicator();


                                        }else{

                                          return Text('center');
                                        }


                                        });












                                      }else {


                                        //If Data dont exist, or still loading
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 20, right: 20),
                                          child: Container(
                                            height: 200,
                                            child: Shimmer(
                                              child: Container(


                                              ),
                                            ),
                                          ),
                                        );
                                      }

                                    },
                                  )
                                ),
                              ),
                            ),
                          ),
                        ),
                      );


                    });





                    //Waiting
                  }else if(snapshot.connectionState == ConnectionState.waiting){


                    return Container(

                      height: 200,child:
                      Shimmer(child: Container(
                        height: 200,
                        width: width,
                      ),),
                    );
                  }
                  else{

                    return Center(child: Text(''
                        ''
                        'cc'),);
                  }


                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
