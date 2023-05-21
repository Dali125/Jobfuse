

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

String client = 'client';
String freelancer = 'freelancer';
class RegisterModel {
  String email;
  String password;
  String fname;
  String lname;
  String nrcc;
  int number;
  String userName;
  final imageUrl;
  final about;
  final List<String> interests;


  RegisterModel(this.imageUrl, this.about, this.interests, {required this.email, required this.password, required this.fname, required this.lname, required this.nrcc, required this.number, required this.userName});

  Future registerUser() async {

    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await Future.delayed(Duration(seconds: 4));
      FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      storeUserDetails(fname, lname, nrcc, number, userName,imageUrl, about, interests);
      createWallet();
    }on FirebaseAuthException catch(e){
      if (kDebugMode) {
        if (kDebugMode) {
          print("Failure");
        }
      }
    }
  }

  storeUserDetails(String firstname, String lastname, String nrc, int phoneNumber, String username, String imageUrl,String about, List<String> interests){


    try{



      FirebaseFirestore.instance.collection('users').add({
        'First_name':firstname,
        'Last_name': lastname,
        'NRC_NUMBER' :nrc,
        'Phone_Number': phoneNumber,
        'UserName': username,
        'Userid' : FirebaseAuth.instance.currentUser!.uid.toString(),
        'imageUrl': imageUrl,
        'about': about,
        'email': FirebaseAuth.instance.currentUser!.email.toString(),
        'interests':interests

      }).whenComplete(() => Fluttertoast.showToast(msg: 'Registration Successful'));


    } catch (e){
      print('write error');
    }


  }



  Future createWallet() async{

    await FirebaseFirestore.instance.collection('wallet').add({
    'Userid': FirebaseAuth.instance.currentUser!.uid.toString(),
     'balance' : 0


});

  }

}
