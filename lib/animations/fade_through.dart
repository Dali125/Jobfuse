
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class _FadeThroughTransitionSwitcher extends StatelessWidget {


  final Widget child;
  final Color fillColor;

  const _FadeThroughTransitionSwitcher({Key? key, required this.child, required this.fillColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher
      (transitionBuilder: (child, animation, secondaryAnimation){

        return FadeThroughTransition(
            fillColor : fillColor,
            animation: animation,
            secondaryAnimation: secondaryAnimation

        );
    },
    child: child,


    );
  }
}
