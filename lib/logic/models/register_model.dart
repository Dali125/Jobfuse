

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String client = 'client';
String freelancer = 'freelancer';
class RegisterModel {
  String email;
  String password;
  String fname;
  String lname;
  String nrcc;
  int number;
  String user_name;


  RegisterModel({required this.email, required this.password, required this.fname, required this.lname, required this.nrcc, required this.number, required this.user_name});

  Future registerUser() async {

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      storeUserDetails(fname, lname, nrcc, number, user_name);
    }on FirebaseAuthException catch(e){
      print("Failure");
    }
  }

  Future storeUserDetails(String firstname, String lastname, String nrc, int phonenumber, String username) async{


    try{



      await FirebaseFirestore.instance.collection('users').add({
        'First_name':firstname,
        'Last_name': lastname,
        'NRC_NUMBER' :nrc,
        'Phone_Number': phonenumber,
        'UserName': username,
        'Userid': FirebaseAuth.instance.currentUser!.uid

      });


    } catch (e){
      print('write error');
    }


  }
}
