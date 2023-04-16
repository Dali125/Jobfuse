import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobfuse/logic/models/submit_proposal.dart';
import 'package:jobfuse/ui/colors/colors.dart';
import 'package:jobfuse/ui/components/posts_page/post_edit.dart';
import 'package:jobfuse/ui/components/posts_page/posts.dart';
import 'package:jobfuse/ui/components/ui-rands/alert_diaog.dart';
import 'package:jobfuse/ui/components/ui-rands/my_button.dart';
import 'package:jobfuse/ui/components/ui-rands/text_guides.dart';
import 'package:smart_alert_dialog/smart_alert_dialog.dart';

import '../../../logic/edit_post.dart';
import '../home/home.dart';


//Function to view a post
class SelectedPost extends StatefulWidget {

  String experienceLevel;
  String clientId;
  String description;
  String title;
  int budget;
  String duration;
  String documentId;
  SelectedPost({Key? key,required this.experienceLevel, required this.description, required this.title
  ,required this.budget, required this.clientId, required this.duration, required this.documentId
  }) : super(key: key);

  @override
  State<SelectedPost> createState() => _SelectedPostState();
}

class _SelectedPostState extends State<SelectedPost> {


  //Current User/Freelance ID
  String myId = FirebaseAuth.instance.currentUser!.uid.toString();

  @override
  Widget build(BuildContext context) {


    //Width of Screen
    double width = MediaQuery.of(context).size.width;

    //Height of Screen
    double height = MediaQuery.of(context).size.height;
    print(height.toString());
    print({height-150}.toString());
    return


        Scaffold(
          appBar: AppBar(
            title: const Center(child: Text('Job Details     ',style: TextStyle(fontSize: 30),)),
            backgroundColor: AppColors.logColor,
          ),

          body:



              //Getting Post from Database
                StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('users').where('Userid', isEqualTo: widget.clientId).snapshots(),
                  builder: (context, snapshot){

                    if(snapshot.hasData){

                      var data = snapshot.data?.docs.toList();

                      print(data?[0].get('UserName'));

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: width,
                              height: height - 180,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(height:
                                    10,),
                                    Text(widget.title,style: const TextStyle(
                                        fontSize: 27,
                                        fontWeight: FontWeight.bold
                                    ),),

                                    SizedBox(height: 10,),
                                  Text('Posted by :  ${data?[0].get('UserName')}',style: TextStyle(fontSize: 20),),
                                    SizedBox(
                                      height: 10,
                                    ),

                                    Text('Client Description',style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26
                                    ),),
                                    SizedBox(height: 10,),


                                    Text(widget.description, style: TextStyle(
                                    ),),

                                    SizedBox(height: 10,),
                                    TextGuide(fontSize: 20, text: 'Estimated Project Duration', padding: 1),
                                    Text(widget.duration),


                                    SizedBox(height: 10,),
                                    TextGuide(fontSize: 20, text: 'Experience Level', padding: 1),

                                    Text(widget.experienceLevel),
                                    
                                    SizedBox(height: 10,),
                                    Text('Estimated Budget', style: TextStyle(fontSize: 20),),
                                    
                                    Text(widget.budget.toString())




                                  ],
                                ),
                              ),
                            ),
                          ),
                          //For the Button to apply
                          Expanded(
                              flex: 1,
                              child: widget.clientId == myId ? Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    MyButton(onTap: (){


                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PostEdit(
                                        experienceLevel: widget.experienceLevel,
                                        description: widget.description,
                                        title: widget.title,
                                        budget: widget.budget,
                                        clientId: widget.clientId,
                                        duration: widget.duration,
                                        projectID: widget.documentId


                                      )));

                                    }, buttonText: 'Edit Post'),
                                    SizedBox(width: 15,),
                                    //To Delete a post
                                    MyButton(onTap: (){

                                      print('tapped to delete');
                                     EditPost editpost = EditPost(budget: widget.budget,
                                         description: widget.description,
                                         documentId: widget.documentId,
                                         duration: widget.duration,
                                         experiencelevel: widget.experienceLevel,
                                         title: widget.title);

                                      editpost.deletePost();


                                      Fluttertoast.showToast(msg: 'Operation Successfull', gravity: ToastGravity.BOTTOM);


                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));



                                    }, buttonText: 'Delete Post')
                                  ],
                                ),
                              ) :
                              MyButton(onTap: (){



                                try{


                                  ProposalSubmission psub = ProposalSubmission(widget.clientId, myId, widget.documentId);

                                  psub.submitProposal();



                                }catch (e){


                                  return Fluttertoast();
                                }




                              }, buttonText: 'Apply')
                          )

                        ],
                      );



                    }else{


                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }


                  }
                ),

        );
  }
}
