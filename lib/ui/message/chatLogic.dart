import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import 'package:shimmer_animation/shimmer_animation.dart';

import '../colors/colors.dart';

class GetMessages extends StatelessWidget {
  //The document id
  final String docIddd;

  //Constructor
  const GetMessages({Key? key, required this.docIddd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //All collections, which match the document id
    CollectionReference messages =
    FirebaseFirestore.instance.collection('messages');

    return FutureBuilder<DocumentSnapshot>(
        future: messages.doc(docIddd).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;


            return DelayedDisplay(
                delay: Duration(milliseconds: 300),
                child: GestureDetector(
                    onTap: () {

                      print('tapppeddd');
                    },
                    child: Container(
                        margin: EdgeInsets.only(bottom: 15.0),
                        padding: EdgeInsets.only(bottom: 3),
                        decoration: BoxDecoration(
                          border: Border.symmetric(horizontal: BorderSide(color: Color(
                              0xff777575))),

                        ),
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
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 20, 0, 0),
                                  child: Text(data['title'].toString(),style: TextStyle(fontWeight: FontWeight.bold, color: Color(
                                      0xff3d2d49)),),
                                ),
                                Padding(
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
                                          EdgeInsetsDirectional.fromSTEB(
                                              20, 0, 0, 0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Less than 30 hrs/week',style: TextStyle(fontWeight: FontWeight.bold, color: Color(
                                                  0xff3d2d49)),
                                              ),
                                              Text('Hours Needed',style: TextStyle(fontSize: 12, color: Color(
                                                  0xffabaeb1)),),
                                              SizedBox(height: 5,),
                                              Text(
                                                data['ExperienceLevel'].toString(),style: TextStyle(fontWeight: FontWeight.bold, color: Color(
                                                  0xff3d2d49)),
                                              ),
                                              Text('Experience Level',style: TextStyle(fontSize: 12, color: Color(
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
                                  decoration: BoxDecoration(),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 0, 0, 0),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Less than 1 month',
                                        ),
                                        Text('Duration',style: TextStyle(fontSize: 12, color: Color(
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
                            child: Container(
                              height: 90,
                              width: width,
                              child: Text(data['Description'].toString()),
                            ),
                          )
                        ]))));
          } else {
            return Shimmer(
                color: AppColors.splashColor,
                child: Container(
                  width: width,
                  height: 250,
                ));
          }
        }));
  }
}
