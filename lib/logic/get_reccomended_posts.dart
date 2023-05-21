import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobfuse/ui/components/posts_page/selected_posts.dart';
import 'package:jobfuse/ui/profile_page/stalker_profile_view.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../ui/colors/colors.dart';
import '../ui/components/posts_page/tabs/Search.dart';

class GetRecommendedPosts extends StatefulWidget {
  //The document id
  var postDetails;

  //Constructor
  GetRecommendedPosts({Key? key, required this.postDetails}) : super(key: key);

  @override
  State<GetRecommendedPosts> createState() => _GetRecommendedPostsState();
}

class _GetRecommendedPostsState extends State<GetRecommendedPosts> {
  bool selected = false;
  //The UserId
  String currentUserId = FirebaseAuth.instance.currentUser!.uid.toString();



  @override
  void initState() {
    super.initState();
    // Add code after super
    _checkIsBookmarked();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;





    //Bookmark reference
    final CollectionReference bookmarksReference = FirebaseFirestore.instance.
    collection('bookmarks');





    return InkWell(
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
                    child: DelayedDisplay(
                      delay: const Duration(milliseconds: 600),
                      child: FutureBuilder(
                          future: FirebaseFirestore.instance.collection('users').
                          where('Userid', isEqualTo: widget.postDetails['Client_id']).get(),
                          builder: (context, snapshot) {

                            var data2 = snapshot.data?.docs[0];
                            Map<String, dynamic>? data22 = data2?.data();


                            if (snapshot.hasData) {
                              return FadeIn(
                                delay: const Duration(milliseconds: 300),
                                child: data22 == null ? const CircularProgressIndicator() :

                                ListTile(
                                  leading: CircleAvatar(
                                    child: InkWell(
                                      child: CachedNetworkImage(imageUrl: data22['imageUrl'],

                                      ),
                                      onTap: (){

                                        print('Clicked');
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => StalkerView(userId: data22['Userid'])));
                                      },
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
                          }),
                    )),
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

                        Text(widget.postDetails['title'], style: TextStyle(
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
                              Text(widget.postDetails['Duration'],
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.splashColor
                                ),
                              ),
                              Text(widget.postDetails['ExperienceLevel'],
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
                              Text(widget.postDetails['Budget'].toString(),
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
                  child: Text(widget.postDetails['Description'],
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


                      //The bookmark button
                      IconButton(
                          enableFeedback: true,
                          onPressed: (){
                            _toggleBookmark();

                          }, icon: selected ? const Icon(Icons.bookmark) : const Icon(Icons.bookmark_border)

                      ),

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
            experienceLevel: widget.postDetails['ExperienceLevel'],
            description: widget.postDetails['Description'],
            title: widget.postDetails['title'],
            budget: widget.postDetails['Budget'],
            clientId: widget.postDetails['Client_id'],
            duration: widget.postDetails['Duration'],
            documentId : widget.postDetails['DocumentID']),  ));
      },
    );
  }



  void _checkIsBookmarked() async {
    final snapshot =
    await FirebaseFirestore.instance.collection('bookmarks').doc(widget.postDetails['DocumentID']).get();
    if (snapshot.exists) {
      setState(() {
        selected = true;
      });
    }
  }


//Setting the bookmark on or off
  void _toggleBookmark() async {
    if (selected) {
      await FirebaseFirestore.instance.collection('bookmarks').doc(widget.postDetails['DocumentID']).delete();
      setState(() {
        selected = false;
      });
    } else
    {
      await FirebaseFirestore.instance.collection('bookmarks').doc(widget.postDetails['DocumentID']).set({
        'userId': currentUserId,
        'itemId': widget.postDetails['DocumentID'],
        // add any other relevant data here
      });
      setState(() {
        selected = true;
      });
      Fluttertoast.showToast(msg: 'Bookmark Saved');
    }
  }



}




