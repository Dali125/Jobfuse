import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/logic/models/users_model.dart';
import 'package:jobfuse/ui/colors/colors.dart';
import 'package:jobfuse/ui/components/ui-rands/my_button.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ReceivedBlock extends StatefulWidget {
  final freelanceID;
  const ReceivedBlock({Key? key, this.freelanceID}) : super(key: key);

  @override
  State<ReceivedBlock> createState() => _ReceivedBlockState();
}

class _ReceivedBlockState extends State<ReceivedBlock> {






  @override
  void initState(){

    super.initState();



  }

  @override
  Widget build(BuildContext context) {



    double width = MediaQuery.of(context).size.width;
    return

      FutureBuilder(
          future: FirebaseFirestore.instance.collection('users').where('Userid', isEqualTo: widget.freelanceID).get(),
          builder: (context, snapshot){

            var userData = snapshot.data?.docs[0];

            if(snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Material(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  decoration: BoxDecoration(border: Border.all()
                    , borderRadius: BorderRadius.circular(15)


                    ,),
                  height: 300,
                  width: width,
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          height: 150,
                          width: width,
                          child: Text('From +${userData?['UserName']}'),

                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 150,
                          width: width,

                          child:
                          Padding(

                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                MyButton(onTap: () {}, buttonText: 'Hire    '
                                ),
                                MyButton(onTap: () {}, buttonText: 'Message'),

                              ],
                            ),
                          ),
                        ),
                      )
                      ,const SizedBox(height: 30,)


                    ],
                  ),
                ),
              ),
            );
          }else {
            return Shimmer(
              color: AppColors.logColor,

              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(

                  height: 300,
                ),
              ),
            );
          }

      });
  }
}
