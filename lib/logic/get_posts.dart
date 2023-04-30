import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/ui/components/posts_page/selected_posts.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../ui/colors/colors.dart';

class GetPosts extends StatelessWidget {
  //The document id
  final String docIddd;

  //Constructor
  const GetPosts({Key? key, required this.docIddd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    //All collections, which match the document id
    CollectionReference posts =
        FirebaseFirestore.instance.collection('ProjectTasks');


    return FadeIn(
      delay: const Duration(milliseconds: 1500),
      child: FutureBuilder<DocumentSnapshot>(
          future: posts.doc(docIddd).get(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              //All data from the database, as a json object
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              String? userId = data['Userid'];

              return DelayedDisplay(
                  delay: const Duration(milliseconds: 300),




                  //This is where we will design the homepage
                  child: InkWell(
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      elevation: 20,
                      shadowColor: AppColors.splashColor2,
                      child: Container(
                        decoration: BoxDecoration(

                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        height: 430,


                        child: Column(
                          children: [

                            //The User Who Posted
                          Expanded(
                            child: SizedBox(
                            height: 80,
                            width: width,
                            child: FutureBuilder(
                                      future: FirebaseFirestore.instance.collection('users').
                                where('Userid', isEqualTo: userId?.toString()).get(),
                                      builder: (context, snapshot) {

                                        var data2 = snapshot.data!.docs[0];
                                        Map<String, dynamic> data22 = data2.data();

                                        if (snapshot.hasData) {
                                          return FadeIn(
                                            delay: const Duration(milliseconds: 300),
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                child: CachedNetworkImage(imageUrl: data22['imageUrl'],

                                                ),
                                              ),
                                              title: Text('${data22['First_name']} ${data22['Last_name']}'),
                                              subtitle: const Text('Time',),
                                            ),
                                          );
                                        } else if (snapshot.hasError) {
                                          return const Icon(Icons.error_outline);
                                        } else {
                                          return const CircularProgressIndicator();
                                        }
                                      })),
                          ),
                            Container(

                              decoration: const BoxDecoration(
                                  color: Colors.white,

                              ),


                              height: 200,
                              width: width,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20,right: 25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    Text(data['title'], style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.splashColor
                                    ),),

                                    SizedBox(
                                      height: 30,
                                      width: width,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Duration',
                                            style: TextStyle(
                                            fontSize: 18, fontWeight: FontWeight.bold,
                                            color: AppColors.splashColor
                                          ),
                                          ),
                                          Text('Experience Level',
                                              style: TextStyle(
                                                  fontSize: 18, fontWeight: FontWeight.bold,
                                                  color: AppColors.splashColor
                                              ))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                      width: width,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(data['Duration'],
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: AppColors.splashColor
                                            ),
                                          ),
                                          Text(data['ExperienceLevel'],
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: AppColors.splashColor
                                              ))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                      width: width,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Budget',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.splashColor
                                            ),
                                          ),
                                          Text(data['Budget'].toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: AppColors.splashColor
                                              ))
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              )
                            ),
                      SizedBox(

                    height: 90,
                    width: width,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: Text(data['Description'],
                          style: TextStyle(
                            color: AppColors.splashColor
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,),
                        ),
                    ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                child:
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [

                                    IconButton(onPressed: (){

                                    }, icon: const Icon(Icons.thumb_up_alt_outlined)),

                                    IconButton(onPressed: (){

                                    }, icon: const Icon(Icons.bookmark_add_outlined)),

                                    IconButton(onPressed: (){

                                    }, icon: const Icon(Icons.share)),
                                  ],
                                ),
                              ),
                            ),





                          ],
                        ),
                      ),
                    ),
                    onTap: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context)
                      =>  SelectedPost(
                          experienceLevel: data['ExperienceLevel'],
                          description: data['Description'],
                          title: data['title'],
                          budget: data['Budget'],
                          clientId: data['Client_id'],
                          duration: data['Duration'],
                          documentId : data['DocumentID']),  ));
                    },
                  ),);




            } else {
              return Shimmer(
                  color: AppColors.logColor,
                  child: Material(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      width: width,
                      height: 400,
                    ),
                  ));
            }
          })),
    );
  }
}

