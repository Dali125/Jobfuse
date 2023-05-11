import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/logic/get_posts.dart';

class MyBookmarks extends StatefulWidget {
  const MyBookmarks({Key? key}) : super(key: key);

  @override
  State<MyBookmarks> createState() => _MyBookmarksState();
}

class _MyBookmarksState extends State<MyBookmarks> {


  //Viewing Current UserId
  String myUserId = FirebaseAuth.instance.currentUser!.uid.toString();

  //We want to get the bookmark collection here
  CollectionReference bookmarkRef = FirebaseFirestore.instance.collection('bookmarks');


  //We want to get the bookmark collection here
  CollectionReference postRef = FirebaseFirestore.instance.collection('bookmarks');


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: SizedBox(


        height: height,
        width: width,

        //Match entries with
        child: StreamBuilder(
            stream: bookmarkRef.where('userId', isEqualTo: myUserId).snapshots(),
            builder: (context,snapshot) {
              if (snapshot.hasData) {

                return ListView.separated(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index){

                      //The data that we want to get from the proposal collection
                      var data = snapshot.data!.docs[index];

                      return Container(
                        height: height,
                        width: width,
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance.collection('ProjectTasks')
                            .where('DocumentID', isEqualTo: data['itemId']).snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(itemBuilder: (context, index2){

                                  var projectData = snapshot.data!.docs[index2];

                                  return GetPosts(docIddd: projectData['DocumentID']);




                                });
                              } else if (snapshot.hasError) {
                                return Icon(Icons.error_outline);
                              } else {
                                return CircularProgressIndicator();
                              }
                            }),
                      );


                }, separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 20,
                      );
                },);
              } else if (snapshot.hasError) {
                return Icon(Icons.error_outline);
              } else {
                return CircularProgressIndicator();
              }
            }),


      ),
    );
  }
}
