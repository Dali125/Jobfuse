import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:jobfuse/ui/components/ui-rands/my_button.dart';
import 'package:uuid/uuid.dart';


class CardPay extends StatefulWidget {
  const CardPay({super.key});



  @override
  _CardPayState createState() => _CardPayState();
}

class _CardPayState extends State<CardPay> {
  final formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();

  final narrationController = TextEditingController();

  final encryptionKeyController = TextEditingController();

  final phoneNumberController = TextEditingController();

  String selectedCurrency = "";



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 25, right: 25),
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: amountController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(hintText: "Amount"),
                  validator: (value) =>
                  value!.isNotEmpty ? null : "Amount is required",
                ),
              ),




              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: TextFormField(
                  controller: phoneNumberController,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: "Phone Number",
                  ),
                ),
              ),

              MyButton(onTap: () async{

                print('object');
                _onPressed();
              }, buttonText: 'Continue')
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _onPressed() {
    if (formKey.currentState!.validate()) {
      _handlePaymentInitialization();
    }
  }

  _handlePaymentInitialization() async {
    final Customer customer = Customer(email: FirebaseAuth.instance.currentUser!.email.toString());

    final Flutterwave flutterwave = Flutterwave(
        context: context,
        publicKey:getPublicKey(),

        currency: 'ZMK',

        redirectUrl: 'https://facebook.com',
        txRef: const Uuid().v1(),
        //To get the amount
        amount: amountController.text.toString().trim(),
        customer: customer,
        paymentOptions: "card",
        customization: Customization(title: "Test Payment"),
        isTestMode: true);
    final ChargeResponse response = await flutterwave.charge();
    if (response != null) {
      showLoading(response.toString());
      if(response.status == 'successful'){


      }
      if (kDebugMode) {
        print("${response.toJson()}");
      }
    } else {
      showLoading("No Response!");
    }
  }

  String getPublicKey() {
    return "FLWPUBK_TEST-45b9580aa5d7bce2aacf9ee82af3592f-X";
  }



  Future<void> showLoading(String message) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            width: double.infinity,
            height: 50,
            child: Text(message),
          ),
        );
      },
    );
  }
}