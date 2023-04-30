
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class Hire{
final String currentUserId;
final String freelanceUserId;
final String proposalsID;


  Hire( { required this.currentUserId,
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
        currentUserId,
        freelanceUserId
      },
      'projectID': proposalsID,
      'status': 'ongoing'


    });

  }



}