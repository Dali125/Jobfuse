library hire_logic;
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
export 'package:jobfuse/logic/hire_logic.dart' show confirmHire;

class Hire{
final String currentUserId;
final String freelanceUserId;
final String proposalsID;
final String docID;


  Hire(this.docID,  { required this.currentUserId,
        required this.freelanceUserId,required this.proposalsID,
  });



  Future confirmHire() async{


    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));


    String newDocID = getRandomString(20);

    await FirebaseFirestore.instance.collection('contracts').doc(newDocID).set({

      'BeginDate' : Timestamp.now(),
      'involvedParties': {
        //The Client
        currentUserId,

        //The freelancer
        freelanceUserId
      },
      'projectID': proposalsID,
      'status': 'ongoing'


    }).whenComplete(() => null);
    deleteRequest();

  }

  
  
  deleteRequest(){
    
    FirebaseFirestore.instance.collection('proposals').doc(docID).delete();
  }


}
