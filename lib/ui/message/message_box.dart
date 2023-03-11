import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../logic/mgroup.dart';


class MessageBox extends StatefulWidget {
  const MessageBox({Key? key}) : super(key: key);

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('messages')
            .where('users',
                arrayContains: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var messageToID2 = snapshot.data!.docs[index];

                 MessageGroup group = MessageGroup(from: messageToID2['from'], to: messageToID2['id_to'], users: messageToID2['users'] as Map<String, dynamic>);
                  print(group.users[0]);


                  return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('messages')
                          .where('users',
                              isNotEqualTo:
                                  FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SizedBox(
                            height: 30,
                            child: ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  var messageToID = snapshot.data!.docs[index];

                                  print(messageToID);

                                  return StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('users')
                                          .where('Userid',
                                              isEqualTo: messageToID['users'])
                                          .snapshots(),
                                      builder: (context, index) {
                                        return SizedBox(
                                          height: 30,
                                          child: ListView.builder(
                                              itemCount:
                                                  snapshot.data!.docs.length,
                                              itemBuilder: (context, index) {
                                                var dat2 =
                                                    snapshot.data!.docs[index];

                                                return Center(
                                                  child: Text(messageToID.toString()),
                                                );
                                              }),
                                        );
                                      });
                                }),
                          );
                        } else {
                          return Center();
                        }
                      });
                });
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        });
  }
}
