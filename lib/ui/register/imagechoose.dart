import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jobfuse/logic/models/register_model.dart';
import 'package:jobfuse/ui/components/ui-rands/mt_textfield.dart';
import 'package:jobfuse/ui/components/ui-rands/text_guides.dart';

import '../components/ui-rands/expanded_text_field.dart';
import '../components/ui-rands/my_button.dart';

class ChooseImage extends StatefulWidget {

  final firstName;
  final lastName;
  final userName;
  final nrc;
  final phoneNumber;
  final email;
  final password;




  const ChooseImage({Key? key, this.firstName, this.lastName, this.userName, this.nrc, this.phoneNumber, this.email, this.password}) : super(key: key);

  @override
  State<ChooseImage> createState() => _ChooseImageState();
}

class _ChooseImageState extends State<ChooseImage> {

TextEditingController about = TextEditingController();

bool isPosted = false;

  File? _image;
void _getImageFromCamera() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

  setState(() {
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  });
}


void _getImageFromGallery() async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

  setState(() {
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  });
}



  void _submitForm() async {

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return const AlertDialog(
            title: Text('Processing'),
            content:  SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Please wait...'),
                  CircularProgressIndicator(), // add a progress indicator
                ],
              ),
            ),
          );
        }
    );
    if (_image != null) {

      // Upload the image to Firebase Storage and get the download URL
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_pictures')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = storageRef.putFile(_image!);
      await uploadTask;
      final imageUrl = await storageRef.getDownloadURL();



      RegisterModel regMod = RegisterModel(imageUrl, 'VJHVJHVJHVH', email: widget.email, password: widget.password, fname: widget.firstName, lname: widget.lastName, nrcc: widget.nrc, number: widget.phoneNumber, userName: widget.userName);

      regMod.registerUser();
      setState(() {
        isPosted = true;
      });

      Fluttertoast.showToast(msg: 'Registration Successful', gravity: ToastGravity.BOTTOM);


      // Hide the processing dialog
      Navigator.of(context).pop();

      Navigator.of(context).pushNamedAndRemoveUntil('login', (Route<dynamic> route) => false);


    }
  }


  @override
  Widget build(BuildContext context) {

  print(widget.userName);
  print('kjojc');
    return Scaffold(

      appBar: AppBar(
        
        leading: IconButton(
          onPressed: (){
            
            
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(

          children: [
            TextGuide(fontSize: 30, text: 'Stand out amongst the crowd,', padding: 10),
            TextGuide(fontSize: 25, text: 'Pick an Image', padding: 10),


            FadeInDown(child: _image != null ?
            CircleAvatar(
                radius: 150,
                child: Image.file(_image!)) : Image.network('https://www.freeiconspng.com/img/23485')

            ),
            SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  MyButton(onTap: (){

                    _getImageFromGallery();

                  }, buttonText: 'From Gallery'
                  ),

                  MyButton(onTap: (){


                    _getImageFromCamera();
                  }, buttonText: 'Camera'
                  )

                ],
              ),
            ),
            SizedBox(height: 20)


            ,const Text('Write an about, for the Stalkers to read'),

            ExpandedTextField(controller: about, hintText: 'I like Balloons', obscureText: false)


            ,SizedBox(height: 30,),

            MyButton(onTap: (){

              _submitForm();


            }, buttonText: 'Complete Registration')

          ],


        ),
      ),
      


    );
  }
}
