
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MakePost{

String budget;
String experienceLevel;
String description;
String duration;
String title;
String clientID;
String taskType;
String category;



 MakePost({required this.budget, required this.duration, required this.title, required this.clientID, required this.description, required this.experienceLevel, required this.category, required this.taskType});



 UploadPost() async{

   const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
   Random _rnd = Random();

   String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
       length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));


   String newDocID = getRandomString(20);
   try{


     print(newDocID);

     await FirebaseFirestore.instance.collection('ProjectTasks').doc(newDocID).set({

       'Budget': budget,
       'TaskType': taskType,
       'Client_id': clientID,
       'title':title,
       'Description':description,
       'Duration' : duration,
       'ExperienceLevel' : experienceLevel,
       'DocumentID' : newDocID,
       'category': category



     }).whenComplete(() => Fluttertoast.showToast(msg: 'msg'));

   }catch (e){


     //

   }
 }

}