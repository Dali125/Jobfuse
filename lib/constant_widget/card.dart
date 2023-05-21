import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(15),
      child: Container(

        height: 250,
        width: width,
        decoration: BoxDecoration(
            color: Colors.blue,
          borderRadius: BorderRadius.circular(15)
        ),
        child: Stack(

          children: [


            Image.network('https://firebasestorage.googleapis.com/v0/b/detail-crud.appspot.com/o/popular_services%2Fexplore.jpeg?alt=media&token=acd16f5a-8e44-4554-9c1e-b1bbee3a4f19',width: width,
            fit: BoxFit.fitWidth,
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(child: Text(

                  'Explore Potential Jobs',
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25)),
              alignment: Alignment.bottomLeft,),
            )
          ],
        )
      ),
    );
  }
}
