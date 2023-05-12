import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobfuse/constant_widget/confirm_hire.dart';
import 'package:jobfuse/logic/hire_logic.dart';
import 'package:jobfuse/ui/colors/colors.dart';
import 'package:jobfuse/ui/components/ui-rands/my_button.dart';
import 'package:jobfuse/ui/profile_page/stalker_profile_view.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:math' as math;

class ReceivedBlock extends StatefulWidget {
  final String freelanceID;
  final String remarks;
  final String proposalsID;
  final String documentID;
  const ReceivedBlock({Key? key,required this.freelanceID, required this.remarks, required this.proposalsID , required this.documentID}) : super(key: key);

  @override
  State<ReceivedBlock> createState() => _ReceivedBlockState();
}

class _ReceivedBlockState extends State<ReceivedBlock> {


  bool? _expanded2;

  String currentUserId = FirebaseAuth.instance.currentUser!.uid.toString();



  @override
  void initState(){

    super.initState();



  }

  @override
  Widget build(BuildContext context) {



//Dimensions of the screen
    double width = MediaQuery.of(context).size.width;
    double height =MediaQuery.of(context).size.height;
    return FutureBuilder(
      //Getting user details
          future: FirebaseFirestore.instance.collection('users').where('Userid', isEqualTo: widget.freelanceID).get(),
          builder: (context, snapshot){

            //Data is stored here
            var userData = snapshot.data?.docs[0];

            //If data is not null here
            if(snapshot.hasData) {
            return Slidable(

              key: const ValueKey(0),
              startActionPane: ActionPane(

                motion: const ScrollMotion(),
                // dismissible: DismissiblePane(onDismissed: (){}
                //
                //   ,),

                children: [

                  SlidableAction(onPressed: (context){
                    print('Deleted');

                  },
                    backgroundColor: Color(0xFFFE4a49),
                    icon: Icons.delete,
                    label: 'Reject Proposal',
                  ),



                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                child: Material(

                  elevation: 15,
                  shadowColor: AppColors.splashColor2,
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.logColor,
                  child:  Card(
                     clipBehavior: Clip.hardEdge,
                      child: ExpansionWidget(
                          onSaveState: (value) => _expanded2 = value,
                             onRestoreState: () => _expanded2,
                             duration: const Duration(milliseconds: 500),
                             titleBuilder: (_, double easeInValue, bool isExpaned, toogleFunction) {
                                  return Material(
                                     color: Color.lerp(
                                     Colors.white, AppColors.logColor, easeInValue),
                                          child: InkWell(
                                            onTap: () => toogleFunction(animated: true), child: Padding(
                                            padding: EdgeInsets.all(8),
                                                  child: Row(
                                                       crossAxisAlignment: CrossAxisAlignment.start,
                                                       mainAxisAlignment: MainAxisAlignment.start,
                                                       children: [
                                                         //The Profile Picture
                                                         ClipOval(
                                                           child: Material(
                                                             color: Colors.transparent,

                                                             child: Ink.image(
                                                               height: 60,
                                                               width: 60,
                                                               fit: BoxFit.cover,
                                                               image: NetworkImage(userData!['imageUrl']),
                                                               child: InkWell(
                                                                 onTap: (){


                                                                 },
                                                               ),),
                                                           ),
                                                         ),


                                            // Icon(Icons.settings,
                                            //     size: 40, color: Color.lerp(Colors.black, AppColors.splashColor, easeInValue)),
                                                         Text('${userData!['First_name']} ${userData['Last_name']}', style: TextStyle(fontSize: 20,color: Color.lerp(Colors.black, AppColors.splashColor, easeInValue))),

                                                           Transform.rotate(
                                                             angle: -math.pi * 2 * (easeInValue),
                                                             child: PopupMenuButton<int>(

                                                               itemBuilder: (context)=>[



                                                                 //We want a popup, to reveal features such as to view the view profile
                                                                 PopupMenuItem(

                                                                     value: 1,
                                                                     child: InkWell(
                                                                       onTap: (){
                                                                         //HEre
                                                                         Navigator.push(context, MaterialPageRoute(builder: (context) =>

                                                                             StalkerView(userId: widget.freelanceID)));
                                                                       },
                                                                       child: Row(
                                                                         children: [
                                                                           Icon(Icons.person),
                                                                           SizedBox(width: 40,),
                                                                           Text('View Profile'),
                                                                         ],
                                                                       ),
                                                                     ))
                                                               ],

                                                             ),


                                                           ),

                                                     Container(
                                                       color: Colors.transparent,
                                                        height: 1,
                                                        width: easeInValue * math.pi * 15,
                                                  ),
                                                   Transform.rotate(
                                                    angle: math.pi * (easeInValue + 0.5),
                                                    alignment: Alignment.center,
                                                     child: Icon(Icons.arrow_back,
                                                    size: 40,
                                                    color: Color.lerp(AppColors.splashColor,
                                                     Colors.black, easeInValue)),
                                                         )
                                                               ],
                                                   ),
                                  ),
                                          ),
    );
    },
        content: Container(
          width: double.infinity,
          color: Colors.white,
          padding: EdgeInsets.only(left: 10, right: 10),

          child: Column(
              children: [
                const Text('Freelancer Remarks', style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),),
                Text(widget.remarks),

                SizedBox(
                  height:
                  10,
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(onTap: (){

                      //The dialog is used to confirm if the user wants to continue with the action they have specified
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirm Action'),
                            content: Text('Continue with hiring ${userData!['First_name']} ${userData['Last_name'] } ?'),
                            actions: <Widget>[
                              TextButton(onPressed: (){

                                Navigator.of(context).pop();

                                //Calling the Hire Class
                                Hire hire = Hire(

                                    widget.documentID,
                                    currentUserId: currentUserId,
                                    freelanceUserId: widget.freelanceID,
                                    proposalsID: widget.proposalsID);

                                hire.confirmHire();


                              }, child: const Text('Yes', style: TextStyle(color: Colors.green),)),

                              TextButton(
                                onPressed: () {


                                },


                                child: Text('No', style: TextStyle(color: Colors.red),),
                              ),
                            ],
                          );
                        },
                      );


                    }, buttonText: 'Hire'),
                    MyButton(onTap: (){}, buttonText: 'Message'),
                  ],
                )
              ],
          ),
        )),
                  ),
                ),
              ),
            );
          }else if(snapshot.data == null){

              return
                SingleChildScrollView(
                  child: Container(

                  height: height,
                  width: width,

                  child: Column(

                    children: [
                      Shimmer(
                        child: Container(height: 200,
                          width: width
                          ,color:AppColors.logColor),
                      ),
                      SizedBox(height: 10,),
                      Shimmer(
                        child: Container(height: 200,
                            width: width
                            ,color:AppColors.logColor),
                      ),
                      SizedBox(height: 10,),
                      Shimmer(
                        child: Container(height: 200,
                            width: width
                            ,color:AppColors.logColor),
                      ),
                  




                    ],
                  ),
              ),
                );
            }

            else {
            return
              SingleChildScrollView(
                child: Container(

                  height: height,
                  width: width,

                  child: Column(

                    children: [
                      Shimmer(
                        child: Container(height: 200,
                            width: width
                            ,color:AppColors.logColor),
                      ),
                      SizedBox(height: 10,),
                      Shimmer(
                        child: Container(height: 200,
                            width: width
                            ,color:AppColors.logColor),
                      ),
                     



                    ],
                  ),
                ),
              );
          }

      });
  }
}
