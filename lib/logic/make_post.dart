
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class MakePost{

int budget;
String ExperienceLevel;
String Description;
String Duration;
String title;
String Client_id;



 MakePost({required this.budget, required this.Duration, required this.title, required this.Client_id, required this.Description, required this.ExperienceLevel});



 Future UploadPost() async{

   const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
   Random _rnd = Random();

   String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
       length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));


   String newDocID = getRandomString(20);
   try{


     print(newDocID);

     await FirebaseFirestore.instance.collection('ProjectTasks').doc(newDocID).set({

       'Budget': budget,
       'Client_id': Client_id,
       'title':title,
       'Description':Description,
       'Duration' : Duration,
       'ExperienceLevel' : ExperienceLevel,
       'DocumentID' : newDocID



     });

   }catch (e){


     //

   }
 }

}