import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class ProposalSubmission{
  final remarks;
  final clientId;
  final freelanceID;
  final proposalID;

 const ProposalSubmission(this.remarks ,this.clientId, this.freelanceID, this.proposalID);


Future submitProposal() async{


  const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));


  String newDocID = getRandomString(20);

  FirebaseFirestore.instance.collection('proposals').doc(newDocID).set({
    'client_id' : clientId,
    'freelance_id' : freelanceID,
    'proposal_id' : proposalID,
    'document_id' : newDocID,
    'remarks': remarks


  });




}






  }






