import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobfuse/logic/get_posts.dart';
import 'package:jobfuse/logic/make_post.dart';
import 'package:jobfuse/ui/components/posts_page/posts.dart';
import 'package:jobfuse/ui/components/ui-rands/drop_down_for_hours.dart';
import 'package:jobfuse/ui/components/ui-rands/expanded_text_field.dart';
import 'package:jobfuse/ui/components/ui-rands/mt_textfield.dart';
import 'package:jobfuse/ui/components/ui-rands/my_button.dart';
import 'package:jobfuse/ui/components/ui-rands/text_guides.dart';

import '../../colors/colors.dart';
import '../ui-rands/drop_down_field.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {

  //Text Controllers
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final textDrop = SingleValueDropDownController();
  final budgetController = TextEditingController();
  final dropDurationController = SingleValueDropDownController();


  //Client id
  String userPost = FirebaseAuth.instance.currentUser!.uid.toString();


  List myid = [];
  
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('ProjectTasks')
        .get()
        .then((snapshot) => snapshot.docs.forEach((element) {
      print(element.reference);
      myid.add(element.reference.id);
    }));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(



      body: CustomScrollView(
        slivers: [

          const SliverAppBar(

            expandedHeight: 160,
            flexibleSpace: Center(
              child: Text(
                'Create Post'
                    ,style: TextStyle(
                fontSize: 30
              ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                 TextGuide(
                  text: 'Enter Job Title',
                  padding: 25,
                  fontSize: 20,),

                MyTextField(
                    controller: titleController,
                    hintText: 'e.g: Dish Installation Needed',
                    obscureText: false),

                const SizedBox(height: 25,),

                TextGuide(
                  text: 'Enter job Description(Details)',
                  padding: 25,
                  fontSize: 20,),




                ExpandedTextField(controller: descriptionController,
                    hintText: 'e.g: I need to install satellite dishes'
                        'on my apartment flats', obscureText: false),

                const SizedBox(height: 25,),

                 TextGuide(fontSize: 20, text: 'Select Experience Level', padding: 25),

                DropTextField(
              controller: textDrop,
            ),


                const SizedBox(height: 25,),

                TextGuide(
                  text: 'Budget Amount',
                  padding: 25,
                  fontSize: 20,),

                MyTextField(controller: budgetController,
                  hintText: 'e.g: 500',
                  obscureText: false,
                  keyboardType: TextInputType.number,),


                //Duration of the Project/Task
                const SizedBox(height: 25,),

                 TextGuide(
                  text: 'Duration',
                  padding: 25,
                  fontSize: 20,),



                DropTextFieldForHours(
                  controller: dropDurationController,
                ),

                const SizedBox(height: 50,),

                MyButton(
                    buttonText: 'Post',
                    onTap: (){

                      try{
                        print(budgetController);
                        print(dropDurationController.dropDownValue!.name.trim());

                      MakePost makepost =
                            MakePost(budget: int.parse(budgetController.text.trim()),
                                     Duration: dropDurationController.dropDownValue!.name.trim(),
                                     title: titleController.text.trim(), Client_id: userPost ,
                                     Description: descriptionController.text.trim(),
                                     ExperienceLevel: textDrop.dropDownValue!.name.trim());

                      //uploading a post, Hopefully
                      makepost.UploadPost();
                      Fluttertoast.showToast(msg: 'Operation Successfull', gravity: ToastGravity.BOTTOM);

                     
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHome()));

                      }catch(e){

                        //
                      }


                })








              ],


            ),
          )

        ],
      ),

    );
  }
}
