
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/logic/balance_logic.dart';
import 'package:jobfuse/logic/hire_logic.dart';
import 'package:jobfuse/ui/components/ui-rands/my_button.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import '../ui/colors/colors.dart';

class ConfirmHire extends StatefulWidget {

  final String clientId;
  final String freelanceId;
  final String proposalsID;
  final String docID;
  const ConfirmHire({Key? key,required this.docID, required this.clientId, required this.freelanceId, required this.proposalsID,


  }) : super(key: key);

  @override
  State<ConfirmHire> createState() => _ConfirmHireState();
}

class _ConfirmHireState extends State<ConfirmHire> {

  int success = 2;
  @override
  Widget build(BuildContext context) {
    return Container(

      child: AlertDialog(
        shadowColor: AppColors.splashColor2,
        elevation: 15,
        backgroundColor:  AppColors.logColor,
        title: const Text('Are You Sure You want to Proceed with operation?'),
        actions: [



          Container(

            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15)

            ),

            child: Material(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
              child: TextButton(
                onPressed: (){
                  print('object');

                  Navigator.of(context).pop();
                }, child: Text('No', style: TextStyle(color: Colors.white),),
              ),
            ),
          ),

          const SizedBox(width: 10,),
          Container(

            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15)

            ),

            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              child: TextButton(
                onPressed: (){
                  print('object');

                  try{




                    Hire confirm = Hire(widget.docID,currentUserId: widget.clientId, freelanceUserId: widget.freelanceId, proposalsID: widget.proposalsID);
                    confirm.confirmHire();

                    setState(() {

                      success = 0;
                      Future.delayed(const Duration(milliseconds: 600), (){

                        setState(() {
                          success = 0;
    });
                        });
                    });
                    if(success == 0){

                      if (kDebugMode) {
                        print('Success');
                      }
                      StylishDialog(
                        confirmButton: MyButton(onTap: (){


                        },buttonText: 'Continue',),
                        context: context,
                        alertType: StylishDialogType.SUCCESS,
                        title: const Text('This is title'),
                        content: const Text('This is content text'),
                      ).show();


                    }

                  }catch(e){
                    //
                    if (kDebugMode) {
                      print(e);
                    }
                    setState(() {
                      success = 1;
                    });
                  }

                }, child: const Text('Yes', style: TextStyle(color: Colors.black),),
              ),
            ),
          ),




        ],
      ),

    );
  }
}
