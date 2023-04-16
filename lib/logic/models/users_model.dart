
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{



  String firstName;
  String lastName;
  int phoneNumber;
  String userId;
  String  imageUrl;
  String userName;
  String nrc;


  UserModel({

    required this.firstName,
    required this.lastName,
    required this.nrc,
    required this.phoneNumber,
    required this.userId,
    required this.imageUrl,
    required this.userName,
  });


  factory UserModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document
      ){
    final data = document.data();
    return UserModel(


      firstName: data?["First_name"],
      lastName: data?["Last_name"],
      phoneNumber:data?["Phone_Number"],
      userId: data?["Userid"],
      userName: data?["UserName"],
      imageUrl: data?['imageUrl'],
      nrc: data?['NRC_NUMBER'],
    );
  }

  Map<String, dynamic> toJson() => {

    "First_name": firstName,
    "Last_name": lastName,
    "Phone_Number": phoneNumber,
    "Userid": userId,
    "UserName": userName,
    "imageUrl":imageUrl,
    "NRC_NUMBER":nrc
  };








}