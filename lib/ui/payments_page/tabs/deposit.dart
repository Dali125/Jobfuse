import 'package:ade_flutterwave_working_version/core/ade_flutterwave.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/logic/balance_logic.dart';
import 'package:jobfuse/ui/components/ui-rands/drop_down_for_payment_optoons.dart';
import 'package:jobfuse/ui/components/ui-rands/mt_textfield.dart';
import 'package:jobfuse/constant_values/auth_values.dart';
import 'package:jobfuse/ui/payments_page/tabs/transfer_options/payment_options/pay_with_card.dart';
import '../../colors/colors.dart';
import '../../components/ui-rands/my_button.dart';

class Deposit extends StatefulWidget {
  const Deposit({Key? key}) : super(key: key);

  @override
  State<Deposit> createState() => _DepositState();
}

class _DepositState extends State<Deposit> {



  final List<SelectedListItem> _listOfCities = [
    SelectedListItem(
      name: kTokyo,
      value: "TYO",
      isSelected: false,
    ),
    SelectedListItem(
      name: kNewYork,
      value: "NY",
      isSelected: false,
    ),
    SelectedListItem(
      name: kLondon,
      value: "LDN",
      isSelected: false,
    ),
    SelectedListItem(name: kParis),
    SelectedListItem(name: kMadrid),
    SelectedListItem(name: kDubai),
    SelectedListItem(name: kRome),
    SelectedListItem(name: kBarcelona),
    SelectedListItem(name: kCologne),
    SelectedListItem(name: kMonteCarlo),
    SelectedListItem(name: kPuebla),
    SelectedListItem(name: kFlorence),
  ];




  TextEditingController currencyController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  final payTex = SingleValueDropDownController();

  String? get _errorText {
    final text = amountController.value.text;
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Too short';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return CustomScrollView(


      slivers: [
        SliverAppBar(
          backgroundColor: AppColors.logColor,
          stretch: true,
          elevation: 10,
          shadowColor: Colors.black87,
          expandedHeight: 120,
          flexibleSpace: Center(
            child: Text('Money Management',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30
                  ,color: AppColors.splashColor2
              ),),
          ),
        ),

        SliverToBoxAdapter(


          child: SizedBox(
            height: height,
            width: width,
            child: FutureBuilder(
                  future: FirebaseFirestore.instance.collection('users').
                where('Userid',isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString()).get(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {

                     var data = snapshot.data.docs[0];
                      return Column(

                        children: [

                          const SizedBox(
                            height: 30,
                          ),
                          FadeInUp(
                            delay: Duration(milliseconds: 500),
                            child: MyTextField(controller: amountController,
                              hintText: 'Enter Amount',
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              errortext: _errorText,
                            ),
                          ),




                          SizedBox(
                            height: 60,
                          ),
                          Text('The dropdown comes here, choice is confirmed by pressing continue'),



                          InkWell(
                            onTap: (){

                              var data32 = {
                                'amount': "600",
                                'email' : "dalitsongulube@gmail.com",
                                'phone' : "0977106765",
                                'name' : 'Dalitso Ngulube',
                                'title' : "Deposit to Jobfuse Account",
                                'currency': "USD",
                                'tex_ref': "Jobfuse-${DateTime.now().millisecondsSinceEpoch}",
                                'icon' : "",
                                'public_key': "FLWPUBK_TEST-45b9580aa5d7bce2aacf9ee82af3592f-X",
                                'sk_key' : "FLWSECK_TEST-091904fbc6c28d2cf25c06448569de9a-X"

                              };


                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CardPayment()

                              )
                                ,
                              );
                            },
                            child: Container(

                              child: Text('Test'),
                            ),
                          ),

                          FadeInUp(
                              delay: Duration(milliseconds: 700),

                              child: DropTextFieldForPayment(controller: payTex,)),

                          const SizedBox(
                            height: 60,
                          ),

                          FadeInUp(
                            delay: Duration(milliseconds: 900),
                            child: MyButton(onTap: (){








                              MyBalance myb = MyBalance(amount: int.parse(amountController.text.trim().toString()), apiaccepted: 700, uid: FirebaseAuth.instance.currentUser!.uid.toString());
                              myb.increaseBalance();
                              setState(() {
                                _errorText;
                              });

                              _errorText;
                              print(_errorText);

                            }, buttonText: 'Continue'),
                          ),


                          // Expanded(child:
                          //
                          //
                          //   MyTextField(),
                          //
                          //
                          // ),





                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Icon(Icons.error_outline);
                    } else {
                      return CircularProgressIndicator();
                    }
                  })),
        )
      ],
    );
  }
}


