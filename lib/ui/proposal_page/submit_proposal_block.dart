import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_widget/expansion_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobfuse/logic/proposal_deletion.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'dart:math' as math;

import '../colors/colors.dart';
import '../components/ui-rands/my_button.dart';
import '../profile_page/stalker_profile_view.dart';

class SubmittedProposalBlock extends StatefulWidget {

  final String freelanceID;
  final String remarks;
  final String proposalsID;
  final String documentID;
  const SubmittedProposalBlock({Key? key, required this.freelanceID, required this.remarks, required this.proposalsID, required this.documentID}) : super(key: key);

  @override
  State<SubmittedProposalBlock> createState() => _SubmittedProposalBlockState();
}

class _SubmittedProposalBlockState extends State<SubmittedProposalBlock> {

  TextEditingController remarksEdit = TextEditingController();

bool? _expanded2;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height =MediaQuery.of(context).size.height;
    return   FutureBuilder(
        future: FirebaseFirestore.instance.collection('users').where('Userid', isEqualTo: widget.freelanceID).get(),
        builder: (context, snapshot){

          var userData = snapshot.data?.docs[0];



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

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirm Action'),
                          content: const Text('Delete proposal, this action cannot be undone ?'),
                          actions: <Widget>[
                            TextButton(onPressed: ()async{




                              await FirebaseFirestore.instance.collection('proposals').doc(widget.documentID).delete();


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
                    icon: Icons.delete,
                    label: 'Delete Proposal',
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
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //The Profile Picture
                                  ClipOval(
                                    child: Material(
                                      color: Colors.transparent,

                                      child: Ink.image(
                                        height: 50,
                                        width: 50,
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
                                  Text('${userData['First_name']} ${userData['Last_name']}', style: TextStyle(fontSize: 20,color: Color.lerp(Colors.black, AppColors.splashColor, easeInValue))),
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
                                                children: const [
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
                          padding: const EdgeInsets.only(left: 10, right: 10),

                          child: Column(
                            children: [
                              const Text('My Remarks', style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text(widget.remarks),

                              const SizedBox(
                                height:
                                10,
                              ),

                              //The column where the buttons will be
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MyButton(onTap: (){
                                    showDialog<void>(
                                          context: context,
                                          barrierDismissible:true,
                                          // false = user must tap button, true = tap outside dialog
                                          builder:
                                              (BuildContext dialogContext) {

                                            //The controller for editing the remarks
                                            TextEditingController texed = TextEditingController(text: widget.remarks);
                                            return AlertDialog(
                                              title: const Text('Enter new Remarks'),
                                              //We want to edit remarks, this is where its done
                                              content: TextField(

                                                autofocus: true,
                                                controller: texed,
                                                maxLines: null,
                                                decoration: InputDecoration(
                                                  counterText: '125'

                                                ),



                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text('Submit',style:
                                                    TextStyle(
                                                      color: AppColors.splashColor
                                                    ),),
                                                  onPressed: () {
                                                    updateRemarks(texed.text.trim());
                                                    Navigator.of(dialogContext)
                                                        .pop(); // Dis
                                                    // miss alert dialog
                                                  },
                                                ),
                                                TextButton(
                                                  child: const Text('Cancel',style:
                                                  TextStyle(
                                                      color: Colors.red
                                                  ),),
                                                  onPressed: () {
                                                    Navigator.of(dialogContext)
                                                        .pop(); // Dismiss alert dialog
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }, buttonText: 'Edit Remarks'),

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

            return SizedBox(
              height: height,
              width: width,
              child: Column(
                children: [
                  
                  Shimmer(child:

                  SizedBox(width: width,
                  height: 300,)
                  ),
                  Shimmer(child: SizedBox(width: width,
                    height: 300,))
                ],
              ),
            );
          }

          else {
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

  Future updateRemarks(String remark) async{

    await FirebaseFirestore.instance.collection('proposals').doc(widget.documentID).update(
        {

          'remarks': remark

        }).whenComplete(() => Fluttertoast.showToast(msg: 'Successfully Updated'));
  }
}
