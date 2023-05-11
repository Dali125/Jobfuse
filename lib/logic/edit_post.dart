import 'package:cloud_firestore/cloud_firestore.dart';

class EditPost{
 final budget;
 final description;
 final documentId;
 final duration;
 final experiencelevel;
 final title;


 EditPost({required this.budget,
  required this.description,
  required this.documentId,
  required this.duration,
  required this.experiencelevel,
  required this.title});



  deletePost() async {

  print(documentId);
 await  FirebaseFirestore.instance.collection('ProjectTasks').doc(documentId).delete();

 }
 
 
 

  
 }




