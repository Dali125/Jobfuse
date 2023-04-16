import 'package:flutter/material.dart';


class TextTitle extends StatelessWidget {

  final double fontSize;
  final text;
  final double padding;
  final fontWeight;

  TextTitle({Key? key,required this.fontSize,required this.text, required this.padding, this.fontWeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  Padding(
      padding: EdgeInsets.only(left: padding,
          right: padding),
      child: Text(text, style: TextStyle(
          fontSize: fontSize,
              fontWeight: fontWeight
      ),
      ),
    );
  }
}
