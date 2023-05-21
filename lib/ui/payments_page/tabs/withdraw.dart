import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jobfuse/ui/payments_page/tabs/transfer_options/wallet_to_wallet.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../colors/colors.dart';

class Transfer extends StatefulWidget {


  Transfer({Key? key,}) : super(key: key);

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {



  String userid = FirebaseAuth.instance.currentUser!.uid.toString();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ScaffoldGradientBackground(


      gradient: LinearGradient(
          tileMode: TileMode.repeated,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.logColor,
            Colors.white70,
          ]),
      body: FutureBuilder(
          future: FirebaseFirestore.instance.collection('wallet').
          where('Userid', isEqualTo: userid).get(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {


            if (snapshot.hasData) {

              //Getting balance of the User
              var data = snapshot.data.docs[0];

              return CustomScrollView(


                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    stretch: true,
                    elevation: 12,
                    shadowColor: AppColors.splashColor2,
                    expandedHeight: 120,
                    flexibleSpace: Center(
                      child: Text('Money Management',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: AppColors.splashColor2
                        ),),
                    ),
                  ),

                  SliverToBoxAdapter(


                    child: Column(

                      children: [

                        const SizedBox(
                          height: 40,
                        ),

                        //First Thingy===================================================
                        FadeInLeft(
                          delay: Duration(milliseconds: 500),
                          duration: Duration(milliseconds: 900),
                          from: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left:20, right: 20),
                            child: Material(
                              elevation: 15,
                              shadowColor: AppColors.splashColor2,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.logColor,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(

                                        width: 2,

                                        color: AppColors.splashColor2
                                    )

                                ),
                                height: 120,
                                width: width,
                                child: InkWell(
                                  child: BounceInRight(
                                    delay: Duration(milliseconds: 1000),
                                    child: ListTile(
                                      title: Text('Wallet to Wallet', style: TextStyle(color: AppColors.splashColor,fontWeight: FontWeight.bold),),

                                      subtitle:  Text('Send money to anyone on jobfuse. The funds'
                                          'will be directly sent to their account', style: TextStyle(color: AppColors.splashColor),),
                                      leading: SizedBox(


                                        width: 70,
                                        child: Center(child: WebsafeSvg.asset('assets/jobfuse_icons/deposit_icon.svg')),
                                      ),
                                    ),
                                  ),
                                  onTap: (){



                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseRecepient(
                                      //

                                      balance: data['balance'],

                                    )));
                                    if (kDebugMode) {
                                      print('Wallet to wallet Clicked');
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                            height: 30
                        ),




                        //Second Thingy================================================================
                        FadeInLeft(
                          delay: Duration(milliseconds: 800),
                          duration: Duration(milliseconds: 1100),
                          from: 100,

                          child: Padding(
                            padding: const EdgeInsets.only(left:20, right: 20),
                            child: Material(
                              elevation: 15,
                              shadowColor: AppColors.splashColor2,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(

                                decoration: BoxDecoration(
                                    color: AppColors.logColor,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(

                                      color: AppColors.splashColor2,
                                      width: 2,

                                    )

                                ),

                                height: 120,
                                width: width,
                                child:  InkWell(
                                  child: BounceInRight(
                                    delay: Duration(milliseconds: 1300),
                                    child: ListTile(
                                      title:  Text('Wallet to Mobile Money', style: TextStyle(color: AppColors.splashColor,fontWeight: FontWeight.bold),),

                                      subtitle: Text('Send money to Mobile Money. The funds'
                                        , style: TextStyle(color: AppColors.splashColor),),
                                      leading: SizedBox(


                                        width: 90,
                                        child: Column(
                                          children: [
                                            const Expanded(child: SizedBox(height: 50,)),
                                            Center(child: WebsafeSvg.asset('assets/jobfuse_icons/wallet_to_mobile.svg')),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: (){


                                  },
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(
                            height: 30
                        ),
                        //Third Thingy
                        FadeInLeft(
                          delay: Duration(milliseconds: 1100),
                          duration: Duration(milliseconds: 1300),
                          child: Padding(
                            padding: const EdgeInsets.only(left:20, right: 20),
                            child: Material(
                              elevation: 15,
                              shadowColor: AppColors.splashColor2,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(

                                decoration: BoxDecoration(
                                    color: AppColors.logColor,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(

                                      color: AppColors.splashColor2,
                                      width: 2,

                                    )

                                ),

                                height: 120,
                                width: width,
                                child: BounceInRight(
                                  delay: Duration(milliseconds: 1500),
                                  child: ListTile(
                                    title: Text('Wallet to Bank', style: TextStyle(color: AppColors.splashColor,fontWeight: FontWeight.bold),),
                                    subtitle: Text('Transfer Money from your jobfuse'
                                        'wallet to a bank account', style: TextStyle(color: AppColors.splashColor),),
                                    leading: SizedBox(

                                      width: 70,
                                      child: WebsafeSvg.asset('assets/jobfuse_icons/wallet_to_mobile.svg'),
                                    ),
                                  ),
                                ),

                              ),
                            ),
                          ),
                        )



                      ],
                    ),
                  )
                ],
              );
            }


            else if (snapshot.hasError) {
              return const Icon(Icons.error_outline);
            } else if(snapshot.connectionState == ConnectionState.waiting){
              return SizedBox(
                  width: width,
                  height: height,
                  child: const CircularProgressIndicator()


              );
            }else{
              return SizedBox(
                  width: width,
                  height: height,
                  child: const CircularProgressIndicator()

              );

            }
          }),
    );
  }
}
