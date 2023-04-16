import 'package:flutter/material.dart';
import 'package:jobfuse/ui/colors/colors.dart';
import 'package:jobfuse/ui/components/posts_page/create_post.dart';
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
        Navigator.of(context).push(_createRoute());
        
        
      }, icon: const Icon(Icons.add),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => CreatePost(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.elasticOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      final offsetAnimation = animation.drive(tween);
      return SlideTransition(position: offsetAnimation,child: child,);
    },
  );
}

