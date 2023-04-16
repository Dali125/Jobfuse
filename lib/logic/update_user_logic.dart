import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UpdateUser{

  String UserName;
  String Fname;
  String Lname;
  String Pnumber;
  String Nrc;



  UpdateUser({required this.UserName, required this.Fname, required this.Lname,required this.Pnumber,required this.Nrc,});




  Future PerformUpdate() async{


    try {
      await FirebaseFirestore.instance.collection('users').
      where('Userid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).
      get().then((snapshot) =>
          snapshot.docs.forEach((documentSnapshot) {
            documentSnapshot.reference.update({
              'UserName': UserName,
              'First_name': Fname,
              'Last_name': Lname,
              'Phone_Number': int.parse(Pnumber),
              'NRC_NUMBER': Nrc
            });
          }));
    }catch (e){

      //In Case the Updation Fails


    }

  }




}