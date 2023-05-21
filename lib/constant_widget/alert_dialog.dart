import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/logic/balance_logic.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import '../ui/colors/colors.dart';

class MyDialogue extends StatefulWidget {
  final clientBalance;
  final int currentBalance;
  final int balanceToAdd;
  final String clientuid;
  final String myUserid;
  const MyDialogue(
      {Key? key,
      required this.currentBalance,
      required this.balanceToAdd,
      required this.clientuid,
      required this.myUserid,
      this.clientBalance})
      : super(key: key);

  @override
  State<MyDialogue> createState() => _MyDialogueState();
}

class _MyDialogueState extends State<MyDialogue> {
  int success = 2;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        shadowColor: AppColors.splashColor2,
        elevation: 15,
        backgroundColor: AppColors.logColor,
        title: const Text('Are You Sure You want to Proceed with operation?'),
        actions: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Material(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
              child: TextButton(
                onPressed: () {
                  if (kDebugMode) {
                    print('object');
                  }

                  Navigator.of(context).pop();
                },
                child: const Text(
                  'No',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              child: TextButton(
                onPressed: () {
                  if (kDebugMode) {
                    print('object');
                  }

                  try {
                    MyBalance mybee = MyBalance(
                        amount: widget.currentBalance,
                        apiaccepted: widget.balanceToAdd,
                        uid: widget.myUserid);

                    MyBalance notmybee = MyBalance(
                        amount: widget.clientBalance,
                        apiaccepted: widget.balanceToAdd,
                        uid: widget.clientuid);

                    //Increase Balance of receiver
                    mybee.decreaseBalance();

                    //Decrease Balance of Sender
                    notmybee.increaseBalance();

                    setState(() {
                      success = 0;
                      Future.delayed(const Duration(milliseconds: 600), () {
                        setState(() {
                          success = 0;
                        });
                      });
                    });
                    if (success == 0) {
                      print('Success');
                      StylishDialog(
                        context: context,
                        alertType: StylishDialogType.SUCCESS,
                        title: const Text('Transfer Completw'),
                        content: const Text('Tap anywhere to exit'),
                      ).show();
                    }
                  } catch (e) {
                    //
                    print(e);
                    setState(() {
                      success = 1;
                    });
                  }
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
