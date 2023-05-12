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


class StalkerView extends StatefulWidget {

  final userId;
  const StalkerView({Key? key, required this.userId}) : super(key: key);

  @override
  State<StalkerView> createState() => _StalkerViewState();
}

class _StalkerViewState extends State<StalkerView> {

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
              expandedHeight: 60,
              elevation: 8,
              scrolledUnderElevation: 8,


            ),SliverToBoxAdapter(


                child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('users', )
                        .where('Userid', isEqualTo:widget.userId ).snapshots(),
                    builder: (context, snapshot){

                      if(snapshot.hasData){

                        return SizedBox(
                          height: height*2,
                          width: width,
                          child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index){

                                var data = snapshot.data!.docs[index];

                                return Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(



                                    children: [

                                      FadeInDown(
                                        delay: const Duration(milliseconds: 200),
                                        child: Text('Profile', style: TextStyle(
                                            fontSize: 35
                                        ),),
                                      ),
                                      //The image is defined here
                                      FadeInDown(
                                        child: Stack(
                                            children:

                                            [

                                              //The Profile Picture
                                              ClipOval(
                                                child: Material(
                                                  color: Colors.transparent,

                                                  child: Ink.image(
                                                    height: 128,
                                                    width: 128,
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(data['imageUrl']),
                                                    child: InkWell(
                                                      onTap: (){


                                                      },
                                                    ),),
                                                ),
                                              ),



                                            ]
                                        ),
                                      ),

                                      SizedBox(
                                        height: 24,
                                      ),
                                      FadeInUp(
                                        delay:Duration(milliseconds: 300),
                                        child: Text('${data['First_name']}  ${data['Last_name']}',
                                          style: TextStyle(

                                              fontWeight: FontWeight.bold,
                                              fontSize: 20
                                          ),),
                                      ),
                                      FadeInUp(
                                          delay: Duration(milliseconds: 300),
                                          child: Text(data['UserName'])),

                                      SizedBox(height: 30,),

                                      SizedBox(
                                        height: 40,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            FadeInLeft(
                                              delay: Duration(milliseconds: 450),
                                              child: Text(

                                                'About', style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold
                                              ),
                                              maxLines: 20,),
                                            )
                                          ],
                                        ),
                                      ),
                                      FadeInLeft(child: const Divider()),

                                      width < 600 ? Text(data['about'],
                                        style: TextStyle(fontSize: 20),):
                                      Row(

                                        children: [
                                          FadeInLeft(
                                            delay:Duration(milliseconds: 500),
                                            child: Text(data['about'],
                                              style: TextStyle(fontSize: 20),),
                                          )
                                        ],
                                      ),
                                      Divider(),
                                      FadeInLeft(
                                        delay: Duration(milliseconds: 450),
                                        child: Row(

                                          children: [
                                            Text(

                                              'Ratings and Reviews', style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold
                                            ),
                                              maxLines: 20,),
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.start,
                                        ),
                                      )

                      //The ratings bar will be placed here, and this will show what users have to say about the user and stuff



                                    ],
                                  ),
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
