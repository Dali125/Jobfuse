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



 void deletePost() {

  print(documentId);
   FirebaseFirestore.instance.collection('ProjectTasks').doc(documentId).delete();

 }
 
 
 
 
 // void performEdit() {
 //  FirebaseFirestore.instance.collection('ProjectTasks').
 //      where('DocumentID', isEqualTo: documentId).
 //     set({
 //        'Budget' : budget,
 //        'Description' : description,
 //        'Duration' : duration,
 //        'ExperienceLevel' : experiencelevel,
 //        'title': title
 //       });
 //      }
  
 }




