import 'package:animate_do/animate_do.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../constant_widget/alert_dialog.dart';
import '../../../components/ui-rands/my_button.dart';


class SendMoney extends StatefulWidget {

  final String name;
  final int number;
  final String email;
  final String avatar;
  final String userId;
  final int currentUserbalance;
  const SendMoney({Key? key, required this.name, required this.number, required this.email, required this.avatar, required this.userId, required this.currentUserbalance}) : super(key: key);

  @override
  State<SendMoney> createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  String currentBalance = "";
  var amount = TextEditingController(text: "0.00");


  FocusNode _focusNode = new FocusNode();
  TextEditingController _editingController = new TextEditingController();
  bool isFocused = false;



  List<String> _feedbacks = [
    'Awsome 🙌',
    'Nice 🔥',
    'Cool 🤩',
    'Amazing work 👍🏼',
  ];

  @override
  void initState(){

    super.initState();

    _focusNode.addListener(onFocusChanged);
    currentBalance =  getBalance().toString() ;
  }

  void onFocusChanged() {
    setState(() {
      isFocused = _focusNode.hasFocus;
    });

    print('focus changed.');
  }
  
  
  Future<String> getBalance() async{
    CollectionReference users =
    FirebaseFirestore.instance.collection('wallet');
    var snapshot = await users.
    where('Userid', isEqualTo: widget.userId).get();
    var data = snapshot.docs as Map<String, dynamic>;
    return data['balance'].toString();
}

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Center(child: Text('Send Money', style: TextStyle(color: Colors.black),)),
        leading: const BackButton(color: Colors.black,),
      ),

//The Contents of the app
      body: SingleChildScrollView(


        child: SizedBox(
          width: width,

          child: FutureBuilder(

                future: FirebaseFirestore.instance.collection('wallet').
                  where('Userid' , isEqualTo: widget.userId).get(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {

                    var data = snapshot.data.docs[0];
                    return  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        const SizedBox(height: 50,),

                        //The image goes here, for the recipient
                        FadeInDown(
                          from: 100,
                          duration: const Duration(milliseconds: 1000),
                          child: Container(
                            width: 128,
                            height: 128,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.pink.shade50,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(widget.avatar)),
                          ),
                        ),



                        const SizedBox(height: 50,),


                        //The name of the User We want to send money to
                        FadeInUp(
                            from: 60,
                            delay: const Duration(milliseconds: 500),
                            duration: const Duration(milliseconds: 1000),
                            child:  Text("Send Money To ${widget.name}", style: TextStyle(color: Colors.grey),)),
                        const SizedBox(height: 10,),

                        //The name appears here
                        FadeInUp(
                            from: 30,
                            delay: const Duration(milliseconds: 800),
                            duration: const Duration(milliseconds: 1000),
                            child: Text(widget.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)),

                        const SizedBox(height: 10,),

                        FadeInUp(
                            from: 30,
                            delay: const Duration(milliseconds: 800),
                            duration: const Duration(milliseconds: 1000),
                            child: Text(widget.email, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)),


                        const SizedBox(height: 20,),


                        //The amount that we want to send
                        FadeInUp(
                          from: 40,
                          delay: const Duration(milliseconds: 800),
                          duration: const Duration(milliseconds: 1000),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50.0),
                            child: TextField(
                              controller: amount,
                              textAlign: TextAlign.center,
                              keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
                              onSubmitted: (value) {
                                setState(() {
                                  amount.text = "$value.00";
                                });
                              },
                              onTap: () {
                                setState(() {
                                  if (amount.text == "0.00") {
                                    amount.text = "";
                                  } else {
                                    amount.text = amount.text.replaceAll(RegExp(r'.00'), '');
                                  }
                                });
                              },
                              // inputFormatters: [
                              //   ThousandsFormatter()
                              // ],

                              //The Text box for the amount, using dfault
                              decoration: InputDecoration(
                                  hintText: "Enter Amount",
                                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 20),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  )
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10,),


                        // a ka message
                        FadeInUp(
                          from: 60,
                          delay: const Duration(milliseconds: 800),
                          duration: const Duration(milliseconds: 1000),
                          child: AnimatedContainer(
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            duration: const Duration(milliseconds: 500),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: isFocused ? Colors.indigo.shade400 : Colors.grey.shade200, width: 2),
                              // // boxShadow:
                            ),
                            child: TextField(
                              maxLines: 3,
                              focusNode: _focusNode,
                              controller: _editingController,
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.black,
                              style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                  hintText: "Message For Recipient ...",
                                  hintStyle: TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w500),
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        FadeInUp(
                          from: 60,
                          delay: const Duration(milliseconds: 800),

                          duration: Duration(milliseconds: 1000),
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 30),


                            //The List of Emojis are placed here
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _feedbacks.length,
                              itemBuilder: (context, index) {
                                return FadeInRight(
                                  from: 100,
                                  delay: Duration(milliseconds: index * 500),
                                  duration: Duration(milliseconds: 1000),
                                  child: BouncingWidget(
                                    duration: Duration(milliseconds: 100),
                                    scaleFactor: 1.5,
                                    onPressed: () {
                                      _editingController.text = _feedbacks[index];
                                      _focusNode.requestFocus();
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 20),
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.grey.shade200, width: 2),
                                      ),
                                      child: Text(_feedbacks[index], style: TextStyle(
                                          color: Colors.grey.shade800,
                                          fontSize: 16
                                      ),),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 50,),

                        //The Button Fades in from wherever
                        FadeInUp(
                            duration: const Duration(milliseconds: 1000),



                            child:

                            MyButton(onTap: ()
                            {

                              print(widget.currentUserbalance.runtimeType);
                              //print(object)


                              try {
                                showDialog(
                                    context: context, builder: (context) =>
                                    MyDialogue(
                                      clientBalance: data['balance'],
                                      currentBalance: widget.currentUserbalance,
                                      clientuid: widget.userId.toString(),
                                      balanceToAdd: int.parse(amount.text),
                                      myUserid: FirebaseAuth.instance
                                          .currentUser!.uid.toString(),


                                    ));
                              }catch(e){


                                print(e);
                              }
                            },



                              buttonText: 'Send Money',


                            )
                        ),
                      ],

                    );
                  } else if (snapshot.hasError) {
                    return Icon(Icons.error_outline);
                  } else {
                    return CircularProgressIndicator();
                  }
                })),


      ),


    );
  }
}
