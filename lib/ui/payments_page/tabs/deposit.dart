import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/logic/balance_logic.dart';
import 'package:jobfuse/ui/components/ui-rands/drop_down_for_payment_optoons.dart';
import 'package:jobfuse/ui/components/ui-rands/mt_textfield.dart';
import 'package:jobfuse/constant_values/auth_values.dart';
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
          flexibleSpace: const Center(
            child: Text('Money Management',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30
              ),),
          ),
        ),

        SliverToBoxAdapter(


          child: SizedBox(
            height: height,
            width: width,
            child: Column(

              children: [

                const SizedBox(
                  height: 30,
                ),
                MyTextField(controller: amountController,
                  hintText: 'Enter Amount',
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  errortext: _errorText,
                ),




                SizedBox(
                  height: 60,
                ),
                Text('The dropdown comes here, choice is confirmed by pressing continue'),


              DropTextFieldForPayment(controller: payTex,),

                SizedBox(
                  height: 60,
                ),

                MyButton(onTap: (){

                  MyBalance myb = MyBalance(amount: int.parse(amountController.text.trim().toString()), apiaccepted: 700, uid: FirebaseAuth.instance.currentUser!.uid.toString());
                  myb.increaseBalance();
                  setState(() {
                    _errorText;
                  });

                  _errorText;
                  print(_errorText);

                }, buttonText: 'TestButton'),


                // Expanded(child:
                //
                //
                //   MyTextField(),
                //
                //
                // ),





              ],
            ),
          ),
        )
      ],
    );
  }
}


