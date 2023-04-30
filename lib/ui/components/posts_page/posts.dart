import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

import '../../../logic/get_posts.dart';
import '../../../logic/make_post.dart';
import '../../colors/colors.dart';
import '../../drawer/my_drawer.dart';



class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin{

  final GlobalKey<SliderDrawerState> _sliderDrawerKey =
  GlobalKey<SliderDrawerState>();
  late String title;

  late Animation<double> _animation ;
  late AnimationController _animationController;


  @override
  void initState() {
    title = "Home";


    _animationController = AnimationController(

      duration: Duration(milliseconds: 260), vsync: this,
    );


    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    super.initState();
  }
  List<bool> _isOpen = [];
  List myid = [];

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('ProjectTasks')
        .get()
        .then((snapshot) => snapshot.docs.forEach((element) {
      print(element.reference);
      print(element.reference.id);
      myid.add(element.reference.id);
    }));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return ScaffoldGradientBackground(


      gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            AppColors.logColor,
            Colors.white70,
          ]),
      body:



      CustomScrollView(

          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: height,
                child: Column(
                  children: [
                    LiquidPullToRefresh(
                      backgroundColor: AppColors.splashColor,
                      onRefresh: ()async{
                        setState(() {
                          getDocId();
                        });


                      },
                      child:

                      FutureBuilder(
                        future: getDocId(),
                        builder: (context, snapshot) {
                          return SizedBox(
                            height: height,
                            child: ListView.builder(
                                 itemCount: myid.length,
                                itemBuilder: (context, index) {
                                  return ListTile(title: GetPosts(docIddd: myid[index],));
                                }),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]
      ),

      drawer:MyDrawer(),



    );
  }
}
