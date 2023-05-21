import 'package:flutter/material.dart';

class PaymentOptionBlock extends StatelessWidget {
  
  String image;
  PaymentOptionBlock({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      height: 170,
      width: 170,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        
      ),
      child: Image.asset(image),
    );
  }
}
