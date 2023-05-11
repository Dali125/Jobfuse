import 'package:cloud_firestore/cloud_firestore.dart';

class DeletionProposal{

  final documentId;

  DeletionProposal({required this.documentId});





  void confirmDeletion(){

    FirebaseFirestore.instance.collection('proposals').doc(documentId).delete();
  }

}