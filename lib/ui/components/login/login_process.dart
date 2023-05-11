import 'dart:async';

import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../home/main_home.dart';
import 'login_fail.dart';


class Confirmer extends StatefulWidget {
  const Confirmer({Key? key}) : super(key: key);

  @override
  State<Confirmer> createState() => _ConfirmerState();
}

class _ConfirmerState extends State<Confirmer> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(



        body: StreamBuilder<User?>(

          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot){
            if(snapshot.hasError){

              return const DelayedDisplay(delay: Duration(seconds: 2),child: LoginFail());

            }
            else if(snapshot.hasData){

              return const MainPage();

            }else if(snapshot.connectionState == ConnectionState.waiting){

              return const Center(child: CircularProgressIndicator(),);
            }


            else{

              return const DelayedDisplay(delay: Duration(milliseconds: 275),child: Center(child: CircularProgressIndicator()));
            }

          },
        )
    );
  }
}
