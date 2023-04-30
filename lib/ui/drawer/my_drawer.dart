import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/ui/payments_page/payments_home.dart';
import 'package:jobfuse/ui/settings/settings_home.dart';
import 'package:page_transition/page_transition.dart';

import 'package:shimmer_animation/shimmer_animation.dart';

import '../../logic/models/login_model.dart';
import '../colors/colors.dart';
import '../components/login/login.dart';
import '../profile_page/my_profile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(

      backgroundColor: AppColors.logColor,
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.logColor
            ),
              child: Center(
                  child: Column(children: [
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .where('Userid',
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var data = snapshot.data!.docs[index];
                                  return Center(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 80, 
                                          child:  ClipOval(
                                            child: SizedBox.fromSize(
                                              size: const Size.fromRadius(75),

                                              child: CachedNetworkImage(
                                                imageUrl:data['imageUrl'],
                                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                    CircularProgressIndicator(value: downloadProgress.progress),
                                                errorWidget: (context, url, error) => const Icon(Icons.error),

                                              )
                                            ),
                                          ),
                                        ),
                                        Text(data['UserName']),
                                        Text(FirebaseAuth.instance.currentUser!.email
                                            .toString())
                                      ],
                                    ),
                                  );
                                });
                          } else {
                            return Column(
                              children: [
                                const SizedBox(
                                  height: 80,
                                ),
                                Shimmer(
                                    color:AppColors.splashColor,
                                    child: const SizedBox(
                                      height: 9,
                                      width: 30,

                                    )),
                                const SizedBox(height: 8,),
                                Shimmer(
                                    child: const SizedBox(
                                      height: 9,
                                      width: 30,
                                    )),
                              ],
                            );
                          }
                        }),
                  ]))),
          InkWell(
            child: ListTile(
              leading: const Icon(Icons.credit_card_rounded),
              title: const Text('Money Management'),
              onTap: (){
                Navigator.push(context, PageTransition(child: const PaymentsHome(), type: PageTransitionType.leftToRight));
              },
            ),
          ),
          InkWell(
            child: ListTile(
              leading: const Icon(Icons.account_circle_outlined),
              title: const Text('Profile'),
              onTap: (){
                Navigator.push(context, PageTransition(child: MyProfile(), type: PageTransitionType.fade));
              },
            ),
          ),
          InkWell(
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            onTap: (){

              Navigator.push(context, PageTransition(child: SettingsHome(), type: PageTransitionType.fade));
            },
          ),

          ListTile(leading: Icon(Icons.logout_outlined),title: Text('Logout',style: TextStyle(color: Color(
              0xff330944))),onTap: (){

            LogoutModel model = LogoutModel();
            model.signOut();
            Navigator.pushReplacement(context, PageTransition(child: Login(),type: PageTransitionType.fade));
          },)
        ],
      ),
    );
  }
}
