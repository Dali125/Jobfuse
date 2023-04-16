import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
class UpdatePP extends StatefulWidget {
  const UpdatePP({Key? key}) : super(key: key);

  @override
  State<UpdatePP> createState() => _UpdatePPState();
}

class _UpdatePPState extends State<UpdatePP> {

  String? imageUrl;

  Future uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    XFile? image;

    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;

      image = await _imagePicker.pickImage(source: ImageSource.gallery);
      var file = File(image!.path);
      print(file);

      if (image != null){
        //Upload to Firebase
        var snapshot = await _firebaseStorage.ref()
        //Can upload pictures, videos, or any other media
            .child('images/profile_pictures')
            .putFile(file);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
          FirebaseFirestore.instance.collection('users').
          where('Userid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).
          get().then((snapshot) => snapshot.docs.forEach((documentSnapshot) {

            documentSnapshot.reference.update({'imageUrl': imageUrl});
          }));

        });
      } else {
        print('No Image Path Received');
      }

  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(


      appBar: AppBar(
        title: Text('Upload Image'),
        centerTitle: true,
        elevation: 0.0,

      ),

      body:
        Center(
          child: Column(


            children: [

              Container(
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: (imageUrl != null)
                ? Image.network(imageUrl!)
                : Image.network('https://i.imgur.com/sUFH1Aq.png'),
              ),
              ElevatedButton(onPressed: (){

                uploadImage();
              }, child: const Text("Choose From Gallery", style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),

              ),
              ElevatedButton(onPressed: (){

                Navigator.pop(context);
              }, child: const Text("Save and Exit", style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),

              ),

            ],
          ),
        )

    );
  }
}
