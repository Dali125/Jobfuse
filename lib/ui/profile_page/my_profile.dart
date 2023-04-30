import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/ui/profile_page/update_profile_pic.dart';
import 'package:page_transition/page_transition.dart';

import 'package:shimmer_animation/shimmer_animation.dart';

import '../../logic/models/login_model.dart';
import '../colors/colors.dart';
import '../components/login/login.dart';
import '../personal_info_page/personal_info.dart';


class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  String usernameFromDb = FirebaseAuth.instance.currentUser!.email.toString();
  String myuid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {

    String uname = usernameFromDb;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomScrollView(


        slivers: [

          SliverAppBar(
            collapsedHeight: 60,
            stretch: true,
            shadowColor: AppColors.splashColor2,
            expandedHeight: 100,
            elevation: 8,
            scrolledUnderElevation: 8,
            flexibleSpace: FadeInDown(child: Center(child: Text('My Profile',style: TextStyle(fontSize: 30,),),)),


          ),SliverToBoxAdapter(


            child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('users', )
                .where('Userid', isEqualTo:myuid ).snapshots(),
                builder: (context, snapshot){

                  if(snapshot.hasData){

                    return SizedBox(
                      height: height*2,
                      width: width,
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index){

                            var data = snapshot.data!.docs[index];

                            return Column(

                              children:  [

                                ClipOval(
                                  child: SizedBox.fromSize(
                                    size: Size.fromRadius(70),

                                    child: FadeInUp(
                                      delay: Duration(milliseconds: 200),
                                      child: CachedNetworkImage( 
                                        imageUrl: data['imageUrl'],
                                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                                            CircularProgressIndicator(value: downloadProgress.progress),
                                        errorWidget: (context, url, error) => Icon(Icons.error),
                                      ),
                                    )
                                  ),
                                ),


 
                                FadeInLeft(
                                  delay: Duration(milliseconds: 270),
                                  child: GestureDetector(child: const Text('Update image',style: TextStyle(fontSize: 18),),onTap: (){

                                    Navigator.push(context, PageTransition(child: UpdatePP(), type: PageTransitionType.bottomToTop));
                                  },),
                                ), 
                                const SizedBox(height: 10,),
                                FadeInRight(
                                  delay: Duration(milliseconds: 320),
                                  child: Text(data['UserName'],style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24,color: Color(
                                      0xff3d2d49)),),
                                ),
                                
                                
                                FadeInUp(
                                  delay: Duration(milliseconds: 350),
                                  child: ListTile(leading: Icon(Icons.info_outline),title: Text('Personal Information',style: TextStyle(color: Color(
                                      0xff3d2d49)),),onTap: (){
                                    Navigator.push(context, PageTransition(child: PersonalInfo(), type: PageTransitionType.leftToRightWithFade));
                                  },),
                                ), 
                                FadeInUp(
                                  delay: Duration(milliseconds: 380),
                                  child: ListTile(leading: Icon(Icons.money),title: Text('Earnings',style: TextStyle(color: Color(
                                      0xff3d2d49))),onTap: (){},),
                                ),
                                 FadeInUp(
                                   delay: Duration(milliseconds: 400),
                                   child: ListTile(leading: Icon(Icons.credit_card_outlined),title: Text('Payment Options',style: TextStyle(color: Color(
                                      0xff3d2d49))),onTap: (){},),
                                 ),

 

                               FadeInUp(
                                 delay: Duration(milliseconds: 420),
                                 child: ListTile(leading: Icon(Icons.logout_outlined),title: Text('Logout',style: TextStyle(color: Color(
                                     0xff330944))),onTap: (){

                                   LogoutModel model = LogoutModel();
                                   model.signOut();
                                   Navigator.pushReplacement(context, PageTransition(child: Login(),type: PageTransitionType.fade));
                                  },),
                               )
                              ],
                            );



                      }),
                    );

                  }else{


                    return Shimmer(child: Container(
                      height: height,
                      color: AppColors.splashColor2,
                    ),);
                  }


            })
          ),

        ],
      )

    );
  }
}
