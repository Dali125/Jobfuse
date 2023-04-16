import 'package:flutter/material.dart';

import '../../colors/colors.dart';

class Transfer extends StatefulWidget {
  const Transfer({Key? key}) : super(key: key);

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return CustomScrollView(


      slivers: [
        SliverAppBar(
          backgroundColor: AppColors.logColor,
          stretch: true,
          elevation: 10,
          shadowColor: Colors.black87,
          expandedHeight: 120,
          flexibleSpace: const Center(
            child: Text('Money Management',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30
              ),),
          ),
        ),

        SliverToBoxAdapter(


          child: Column(

            children: [

              //First Thingy
              Padding(
                padding: const EdgeInsets.only(left:20, right: 20),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(

                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(

                        width: 2,

                      )

                    ),

                    height: 120,
                    width: width,

                  ),
                ),
              ),

             const SizedBox(
                height: 30
              ),
              //Second Thingy
              Padding(
                padding: const EdgeInsets.only(left:20, right: 20),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(

                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(

                          width: 2,

                        )

                    ),

                    height: 120,
                    width: width,

                  ),
                ),
              ),

              const SizedBox(
                  height: 30
              ),
              //Third Thingy
              Padding(
                padding: const EdgeInsets.only(left:20, right: 20),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(

                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(

                          width: 2,

                        )

                    ),

                    height: 120,
                    width: width,

                  ),
                ),
              )



            ],
          ),
        )
      ],
    );
  }
}
