import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../colors/colors.dart';
import 'choosechat.dart';
class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: CustomScrollView(

        slivers: [
         SliverAppBar(
           backgroundColor: AppColors.logColor,

            expandedHeight: 120,
            flexibleSpace: Padding(
              padding: const EdgeInsets.only(left: 25, top: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Text('Messages', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: ChooseChat(),)
        ],




      )

    );
  }
}
