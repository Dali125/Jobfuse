import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/ui/colors/colors.dart';
import 'package:jobfuse/ui/components/posts_page/create_post.dart';

import '../components/posts_page/create_step_post.dart';
class MyFAB extends StatefulWidget {
  const MyFAB({Key? key}) : super(key: key);

  @override
  State<MyFAB> createState() => _MyFABState();
}

class _MyFABState extends State<MyFAB> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.logColor
      ),
      child: IconButton(

          onPressed: (){

        showModalBottomSheet(context: context,
            builder: (context){

          return Column(

            children: [
              const SizedBox(
                height: 30,
              ),
              // FadeInUp(
              //
              //   delay: const Duration(milliseconds: 200),
              //   child: ListTile(
              //     leading: const Icon(Icons.add,color: Colors.blue,),
              //     title: const Text('Create Post'),
              //
              //     onTap:(){
              //
              //       Navigator.of(context).push(_createRoute());
              //     },
              //   ),
              // ),
              ListTile(
                title: Text('Dalitso'),

                onTap: (){

                  Navigator.of(context).push(_createStepRoute());

                },
              ),
              ListTile(
                title: Text('Dalitso'),
              ),



            ],
          );


        });
        
      }, icon: const Icon(Icons.arrow_upward),
      ),
    );
  }
}

// Route _createRoute() {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => CreatePost(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(0.0, 1.0);
//       const end = Offset.zero;
//       const curve = Curves.elasticOut;
//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//       final offsetAnimation = animation.drive(tween);
//       return SlideTransition(position: offsetAnimation,child: child,);
//     },
//   );
//
//
// }

Route _createStepRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => StepPost(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.elasticOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      final offsetAnimation = animation.drive(tween);
      return SlideTransition(position: offsetAnimation,child: child,);
    },
  );}

