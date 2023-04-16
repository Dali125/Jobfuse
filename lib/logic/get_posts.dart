import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/ui/components/posts_page/selected_posts.dart';
import 'package:page_transition/page_transition.dart';
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

    return FutureBuilder<DocumentSnapshot>(
        future: posts.doc(docIddd).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            //All data from the database, as a json object
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            return DelayedDisplay(
                delay: Duration(milliseconds: 300),
                child: GestureDetector(
                    onTap: () {

                      print('tapppeddd');

                      Navigator.push(context, PageTransition(
                          childCurrent: this,
                          child: DelayedDisplay(
                        delay: Duration(milliseconds: 200),
                        child: SelectedPost(
                          experienceLevel: data['ExperienceLevel'],
                          description: data['Description'],
                          title: data['title'],
                          budget: data['Budget'],
                          clientId: data['Client_id'],
                          duration: data['Duration'],
                           documentId : data['DocumentID']),
                      ), type: PageTransitionType.bottomToTopPop));
                    },
                    child: Container(

                      decoration:  BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(

                          width: 2.0,
                          color: Colors.grey
                          ,style: BorderStyle.solid

                          ,
                        ),

                      ),

                      child: Material(
                        elevation: 10,

                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 15.0),
                            padding: const EdgeInsets.only(bottom: 3),


                            height: 400,
                            child:
                                Column(mainAxisSize: MainAxisSize.max, children: [
                              Container(
                                width: width,
                                height: 100,

                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          20, 20, 0, 0),
                                      child: Text(data['title'].toString(),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Color(
                                          0xff3d2d49)),),
                                    ),
                                    const Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20, 20, 0, 0),
                                      child: Text(
                                        'Hello World',style: TextStyle(fontWeight: FontWeight.bold, color: Color(
                                          0xff3d2d49)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: width,
                                height: 140,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 200,
                                      height: 140,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(

                                            width: width / 2,
                                            height: 140,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional.fromSTEB(
                                                      20, 0, 0, 0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Less than 30 hrs/week',style: TextStyle(fontWeight: FontWeight.bold, color: Color(
                                                      0xff3d2d49)),
                                                  ),
                                                  const Text('Hours Needed',style: TextStyle(fontSize: 12, color: Color(
                                                      0xffabaeb1)),),
                                                  const SizedBox(height: 5,),
                                                  Text(
                                                      data['ExperienceLevel'].toString(),style: const TextStyle(fontWeight: FontWeight.bold, color: Color(
                                                      0xff3d2d49)),
                                                  ),
                                                  const Text('Experience Level',style: TextStyle(fontSize: 12, color: Color(
                                                      0xffabaeb1)),),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 130,
                                      height: 120,
                                      decoration: const BoxDecoration(),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            20, 0, 0, 0),
                                        child: Column(
                                          children: [
                                            Text(
                                              data['Duration'],
                                            ),
                                            const Text('Duration',style: TextStyle(fontSize: 12, color: Color(
                                                0xffabaeb1)),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(20, 5, 0, 0),
                                    child: SizedBox(
                                      height: 80,
                                      width: width,
                                      child: Text(data['Description'].toString(),
                                      overflow: TextOverflow.ellipsis,),
                                    ),
                                  )
                            ])),
                      ),
                    )));
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
        }));
  }
}

