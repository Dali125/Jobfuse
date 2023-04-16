import 'package:cloud_firestore/cloud_firestore.dart';

class ProposalSubmission{
final clientId;
final freelanceID;
final proposalID;

 const ProposalSubmission(this.clientId, this.freelanceID, this.proposalID);


Future submitProposal() async{

  FirebaseFirestore.instance.collection('proposals').add({
    'client_id' : clientId,
    'freelance_id' : freelanceID,
    'proposal_id' : proposalID


  });




}



  }






