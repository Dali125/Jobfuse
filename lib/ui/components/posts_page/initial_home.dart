import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/constant_widget/popular_services%20card.dart';
import 'package:jobfuse/ui/components/posts_page/recommended_posts.dart';
import 'package:jobfuse/ui/components/posts_page/services/servicesTab.dart';
import 'package:jobfuse/ui/components/posts_page/tabs/Search.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../constant_widget/card.dart';
import '../../colors/colors.dart';

class InitialHome extends StatefulWidget {
  const InitialHome({Key? key}) : super(key: key);

  @override
  State<InitialHome> createState() => _InitialHomeState();
}

class _InitialHomeState extends State<InitialHome> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height,
      width: width,


      //The main thingy
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 30,),
              //The searchbar goes here
              FadeInDown(
                delay: const Duration(milliseconds: 200),
                child: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(

                        border: Border.all(

                            color: AppColors.splashColor2
                        )
                    ),
                    height: 50,
                    child: Material(
                      elevation: 10,
                      shadowColor: AppColors.splashColor2,
                      child:
                      Row(children: [SizedBox(width: 10,),Icon(Icons.search_outlined, size: 40,),SizedBox(width: 30,), Text('Search')],)
                    ),
                  ),onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchJobs()));
                  print('0');
                },
                ),
              ),
              const SizedBox(height: 30,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Explore Popular Services', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  
                  Text('See All')
                ],
              ),
              const SizedBox(height: 10,),

              SizedBox(
                height: 220,
                width: width,
                child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('services').snapshots(),
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context,index){

                                var services = snapshot.data!.docs[index];
                                return Material(
                                  elevation: 10,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      InkWell(child: PopularService(imageUrl: services['image'],category: services['category'],),
                                      onTap: (){

                                        print(services['image']);
                                        print(services['category']);
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => SelecteServices(category: services['category'])));
                                      },),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(services['category']),
                                      )
                                    ],
                                  ),
                                );


                              }, separatorBuilder: (BuildContext context, int index) {
                              return SizedBox(width: 15,);
                          },);
                        } else if (snapshot.hasError) {
                          return Icon(Icons.error_outline);
                        } else {
                          return SizedBox(
                            height: 220,
                            width: width,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                                itemCount: 4,
                                itemBuilder: (context , index){
                                  return Shimmer(
                                      color: Colors.white12,
                                      child: Container(
                                    height: 220,
                                    width: 220,

                                  ));
                                })
                          );
                        }
                      })),
              

              const SizedBox(height: 30,),

              InkWell(child: const MyCard(),
                onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RecommendedPosts()));
                },
              ),



            ],
          ),
        ),
      ),
    );
  }
}
