import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../logic/get_reccomended_posts.dart';

class RecommendedPosts extends StatefulWidget {
  const RecommendedPosts({Key? key}) : super(key: key);

  @override
  State<RecommendedPosts> createState() => _RecommendedPostsState();
}

class _RecommendedPostsState extends State<RecommendedPosts> {

  //We initialise the users id here
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();
  //User interests will update as user adds more interests
  List<String> userInterests = [];

  late  Stream<QuerySnapshot<Map<String, dynamic>>> recommendedPostsStream;


  @override
  void initState() {
    super.initState();

  }

  //we want to get the users interests




//The following widget uses the recommendation algorithm based on the users interests
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),

      //This future builder uses a recommendation algorithm to filter and show what the user can want
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: FutureBuilder(
          //Get the users details, and take note of the users interests using the future builder
        future: FirebaseFirestore.instance.collection('users').where('Userid', isEqualTo: uid).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
           if (snapshot.hasData) {

             //Get all the users data, which will be cleaned to only show the users interests
             var data = snapshot.data.docs[0];
             //Cleaned data will be stored here
             List categories = data['interests'];
             //The stream builder retrieves the possible recommendations for each user
           return StreamBuilder(
               stream: FirebaseFirestore.instance.collection('ProjectTasks').
               where('category', whereIn: categories).snapshots(),
               builder: (BuildContext context,snapshot) {
                 //This is a successful attempt in a scenario where the users recommendations were successful
                 if (snapshot.hasData) {
                   return ListView.separated(
                       itemCount: snapshot.data!.docs.length,
                       itemBuilder: (context, index){

                         var postData = snapshot.data?.docs[index];


                         return GetRecommendedPosts(postDetails: postData,);




                   }, separatorBuilder: (BuildContext context, int index) {
                         return const SizedBox(height: 20,);
                   },);
                 } else if (snapshot.hasError) {
                   return const Icon(Icons.error_outline);
                 } else {
                   return const CircularProgressIndicator();
                 }
               });
    } else if (snapshot.hasError) {
            return const Icon(Icons.error_outline);
    } else {
               return const CircularProgressIndicator();
    }
    }),
      ));
  }
}
