import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/ui/colors/colors.dart';
import 'package:jobfuse/ui/components/ui-rands/my_button.dart';
import 'package:jobfuse/ui/components/ui-rands/text_guides.dart';
class SelectedPost extends StatefulWidget {

  String experienceLevel;
  String clientId;
  String description;
  String title;
  int budget;
  String duration;
  SelectedPost({Key? key,required this.experienceLevel, required this.description, required this.title
  ,required this.budget, required this.clientId, required this.duration
  }) : super(key: key);

  @override
  State<SelectedPost> createState() => _SelectedPostState();
}

class _SelectedPostState extends State<SelectedPost> {

  String myId = FirebaseAuth.instance.currentUser!.uid.toString();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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


                                    }, buttonText: 'Edit Post'),
                                    SizedBox(width: 15,),
                                    MyButton(onTap: (){}, buttonText: 'Delete Post')
                                  ],
                                ),
                              ) :
                              MyButton(onTap: (){}, buttonText: 'Apply')
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
