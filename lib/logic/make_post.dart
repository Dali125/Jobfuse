
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


   try{

     await FirebaseFirestore.instance.collection('ProjectTasks').add({

       'Budget': budget,
       'Client_id': Client_id,
       'title':title,
       'Description':Description,
       'Duration' : Duration,
       'ExperienceLevel' : ExperienceLevel



     });

   }catch (e){


     //

   }
 }

}