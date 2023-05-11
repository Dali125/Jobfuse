import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/ui/colors/colors.dart';
import 'package:jobfuse/ui/components/ui-rands/mt_textfield.dart';

import '../../logic/senderMessage.dart';


class MyChosenChat extends StatefulWidget {
  String currentUser;
  String otherUser;
  String chattername;
  String chatterImage;
  MyChosenChat({Key? key, required this.currentUser, required this.otherUser, required this.chattername, required this.chatterImage})
      : super(key: key);

  @override
  State<MyChosenChat> createState() => _MyChosenChatState();
}

class _MyChosenChatState extends State<MyChosenChat> {
  var _textContrroller = TextEditingController();
  List myId = [];
  String groupId = 'l';

//Checking if the collection exists in the database
  Future compare() async {
    String groupId = "${widget.currentUser}-${widget.otherUser}";
    await FirebaseFirestore.instance
        .collection('chats')
        .get()
        .then((value) => value.docs.forEach((element) {
              print(element);
              myId.add(element.reference.id);
              print(myId);
            }));



    //If it does, set the group id
    if (myId.contains(groupId)) {
      print(groupId);
      this.groupId = groupId;
    } else if (myId.contains("${widget.otherUser}-${widget.currentUser}")) {
      this.groupId = "${widget.otherUser}-${widget.currentUser}";
    }
    else {

      int date = DateTime.now().millisecondsSinceEpoch;
      String currentU = "${widget.currentUser}";
      String groupnewId = "${widget.currentUser}-${widget.otherUser}";
      await FirebaseFirestore.instance.collection('chats').doc(groupnewId).collection(groupId).doc(date.toString()).set(

        {
          'content':'',
          'from' : currentU
        }
      );

    }
  }

  @override
  void initState() {
    super.initState();

    _textContrroller.addListener(() {});
  }

  @override
  void dispose() {
    _textContrroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(

          leading:Container(

            height: 30,
            width: 30,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
                shape: BoxShape.circle),
            child: Image.network(
              widget.chatterImage,
              fit: BoxFit.cover,
            ),
          ),title: Text(widget.chattername),

        ),
        body: FutureBuilder(
          future: compare(),
          builder: (context, snapshot) {
            return Column(
              children: [
                Expanded(
                    child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('chats')
                      .doc(groupId)
                      .collection(groupId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var dat2 = snapshot.data!.docs[index];

                            return Align(
                              alignment:
                                  dat2['from'].toString() == widget.currentUser
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                              child: Card(
                                color: dat2['from'].toString() ==
                                        widget.currentUser
                                    ? const Color(0xff7423c9)
                                    : AppColors.logColor,
                                elevation: 8,
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                    dat2['content'],
                                    style: TextStyle(
                                      color: dat2['from'].toString() ==
                                              widget.currentUser
                                          ? Colors.white
                                          : const Color(0xff3d2d49),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                )),

                //For the text field
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: MyTextField(controller: _textContrroller,


                    hintText: 'enter message', obscureText: false,

                  )
                ),
                Transform.rotate(
                  angle: pi * 2,
                  child : IconButton(
                      onPressed: () {
                        MessageController msg = MessageController(
                            currentUser: widget.currentUser,
                            groupId: groupId,
                            content: _textContrroller.text.trim());
                        msg.sendMessage();

                        _textContrroller.clear();
                      },
                      icon: Icon(Icons.send_sharp)),
                )
              ],
            );
          },
        ));
  }
}
