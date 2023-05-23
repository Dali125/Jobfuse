import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jobfuse/ui/colors/colors.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class Ratings extends StatefulWidget {
  final userID;

  const Ratings({Key? key, this.userID}) : super(key: key);
 
  @override
  State<Ratings> createState() => _RatingsState();
}

class _RatingsState extends State<Ratings> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('user_ratings_and_review')
              .where('reviewed_client_id', isEqualTo: widget.userID)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var ratingData = snapshot.data!.docs[index];
                    // The rating design goes here
                    return FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .where('Userid', isEqualTo: ratingData['reviewer_id'])
                          .get(),
                      builder: (context, snapshot) {
                        var userdata = snapshot.data?.docs[0];
                        DateTime timestamp =
                            ratingData["time_of_review"].toDate();
                        if (snapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              height: 200,
                              width: width,
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(15),
                                color: AppColors.logColor,
                              ),
                              child: ListTile(
                                title: FadeInLeft(
                                  child: Row(
                                    children: [
                                      ClipOval(
                                        child: Material(
                                          color: Colors.transparent,
                                          child: Ink.image(
                                            height: 40,
                                            width: 40,
                                            fit: BoxFit.cover,
                                            image: NetworkImage(userdata?['imageUrl']),
                                            child: InkWell(
                                              onTap: () {},
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10,),
                                      Text('${userdata?['First_name']} ${userdata?['Last_name']}'),
                                      const SizedBox(width: 10,),
                                      Text(timestamp.day.toString()+"/" + timestamp.month.toString()+"/"+ timestamp.year.toString())
                                    ],
                                  ),
                                ),
                                subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10,),
                                    FadeInUp(
                                      child: RatingBar.builder(
                                        itemSize: 20,
                                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                        allowHalfRating: true,
                                        initialRating: ratingData['Rating'],
                                        itemBuilder: (context, _) =>  const Icon(Icons.star, color: Colors.amber),
                                        ignoreGestures: true,
                                        onRatingUpdate: (val) {},
                                      ),
                                    ),
                                    FadeInUp(child: Text(ratingData['review']))
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Column(
                            children: [
                              Shimmer(
                                child: Container(
                                  height: 190,
                                  width: width,
                                  color: AppColors.logColor,
                                ),
                              ),
                              SizedBox(height: 30,),
                              Shimmer(
                                child: Container(
                                  height: 190,
                                  width: width,
                                  color: AppColors.logColor,
                                ),
                              ),
                              SizedBox(height: 30,),
                              Shimmer(
                                child: Container(
                                  height: 190,
                                  width: width,
                                  color: AppColors.logColor,
                                ),
                              ),
                              SizedBox(height: 30,),
                              Shimmer(
                                child: Container(
                                  height: 190,
                                  width: width,
                                  color: AppColors.logColor,
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: snapshot.data!.docs.length,
                ),
              );
            } else {
              return Text('hcghchgchchgcgc');
            }
          },
        ),
      ),
    );
  }
}
