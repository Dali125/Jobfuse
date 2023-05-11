import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:shimmer_animation/shimmer_animation.dart';

import '../colors/colors.dart';
import 'ChosenChat.dart';
class ChooseChat extends StatefulWidget {
  const ChooseChat({Key? key}) : super(key: key);

  @override
  State<ChooseChat> createState() => _ChooseChatState();
}

class _ChooseChatState extends State<ChooseChat> {


  //THe id of the current user
  String CurrentUser = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {

    //The width of the screen
    double width = MediaQuery.of(context).size.width;

    //THe height of the screen
    double height = MediaQuery.of(context).size.height;

    //Getting the chats that the current user is in
    return StreamBuilder(stream: FirebaseFirestore.instance.collection('messages')
        .where('users', arrayContains: CurrentUser).snapshots(), builder: (context, snapshot){


         //If data is there
      if(snapshot.hasData) {
        return SizedBox(
             height: height,
          width: width,
          child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshot.data!.docs[index];

                List otherUser = data['users'];
                otherUser.remove(CurrentUser);
                String otherUserString = otherUser[0];
                print(otherUser[0]);


                return StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('users')
                        .where('Userid', isEqualTo: otherUserString)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SizedBox(
                          height: 66,
                          width: width,
                          child: ListView.separated(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                var userInfo = snapshot.data!.docs[index];


                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all()
                                  ),
                                  height: 66,
                                  width: width,
                                  child: FadeInLeft(
                                    child: Material(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 30),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            
                                            child: Image.network(userInfo['imageUrl']),
                                          ),
                                          title: Text(userInfo['UserName']),
                                          subtitle: Text('hi'),

                                          onTap: () {
                                            Navigator.push(context,
                                                PageTransition(child: MyChosenChat(
                                                  chatterImage: userInfo['imageUrl'],
                                                  chattername: userInfo['UserName'],
                                                    currentUser: CurrentUser,
                                                    otherUser: otherUserString),
                                                    type: PageTransitionType
                                                        .leftToRightWithFade));
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }, separatorBuilder: (context, index) {

                                return SizedBox(
                                  height: 40,
                                );
                          },),


                        );
                      } else {
                        return Column(
                          children: [
                            Shimmer(child: Container(
                              height: 64,
                              width: width,
                              color: AppColors.logColor,
                            )),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        );
                      }
                    });
              }),
        );
      }else {
        return Column(
          children: [
            Shimmer(child: Container(
              height: 64,
              width: width,
              color: AppColors.logColor,
            )),
          ],
        );
      }
    });
  }
}
