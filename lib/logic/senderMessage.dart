import 'package:cloud_firestore/cloud_firestore.dart';

class MessageController{

String currentUser;
String groupId;
String content;


  MessageController({required this.currentUser, required this.groupId, required this.content});





  Future sendMessage() async{


    String timestamp= DateTime.now().millisecondsSinceEpoch.toString();
    await FirebaseFirestore.instance.collection('chats').doc(groupId).collection(groupId).doc(timestamp).set(
        {'from': currentUser,
        'content': content});
  }
}