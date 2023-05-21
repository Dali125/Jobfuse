import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/constant_widget/deposit_options.dart';
import 'package:jobfuse/testerr/ussed_tester.dart';
import 'package:jobfuse/ui/payments_page/tabs/airtelDepo.dart';
import 'package:jobfuse/ui/payments_page/tabs/card.dart';
import 'package:jobfuse/ui/payments_page/tabs/zamtel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ussd_service/ussd_service.dart';

import 'mtn_deposit.dart';

class Deposit extends StatefulWidget {
  const Deposit({Key? key}) : super(key: key);

  @override
  State<Deposit> createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  makeMyRequest() async {
    int subscriptionId = 1; // sim card subscription ID
    String code = "*114#"; // ussd code payload
    try {
      String ussdResponseMessage = await UssdService.makeRequest(
        subscriptionId,
        code,
        Duration(seconds: 10), // timeout (optional) - default is 10 seconds
      );
      print("succes! message: $ussdResponseMessage");
    } catch (e) {
      debugPrint("error! code: ${e} - message: ${e}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text(
            'Deposit',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Choose an option below',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),

                FadeInLeft(
                  child: Row(
                    children: [
                      InkWell(
                          child: PaymentOptionBlock(
                              image:
                                  'assets/mobile_money_icons/AirtelMoneyCharges.png'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AIRTEL()));
                          }),
                      SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        child: PaymentOptionBlock(
                          image:
                              'assets/mobile_money_icons/AirtelMoneyCharges.png',
                        ),
                        onTap: (){

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  CardPay()));
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    InkWell(
                      child: PaymentOptionBlock(
                          image: 'assets/mobile_money_icons/MTN.png'),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MTN()));
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                        child: PaymentOptionBlock(
                            image: 'assets/mobile_money_icons/ZamtelMoney.png'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ZAMTEL()));
                        }),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),

                // Row(
                //   children: const [
                //     PaymentOptionBlock(),
                //     SizedBox(width: 15,),
                //     PaymentOptionBlock(),
                //   ],
                // ),
              ],
            ),
          ),
        )
      ],
    );
  }
}


// curl --request POST \
// --url https://api.flutterwave.com/v3/charges?type=mobile_money_zambia \
// --header 'Authorization: FLWSECK_TEST-091904fbc6c28d2cf25c06448569de9a-X' \
// --header 'content-type: application/json' \
// --data '{
// "phone_number": "0957657513",
// "amount": 1500,
// "currency": "ZMW",
// "network": "ZAMTEL",
// "email": "i@need.money",
// "tx_ref": "MC-3243e"
// }'