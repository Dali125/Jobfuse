import 'package:animate_do/animate_do.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobfuse/ui/components/ui-rands/mt_textfield.dart';
import 'package:jobfuse/ui/components/ui-rands/my_button.dart';
import 'package:jobfuse/ui/register/imagechoose.dart';

import '../../logic/models/register_model.dart';
import '../colors/colors.dart';
import '../components/home/home.dart';
import '../components/login/login.dart';
import 'dart:io';

import '../components/ui-rands/expanded_text_field.dart';
import '../components/ui-rands/text_guides.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _formKey = GlobalKey<FormState>();


  final TextEditingController last_name = TextEditingController();

  final TextEditingController first_name = TextEditingController();

  //The Nrc 9data Stuff
  final TextEditingController nrc = TextEditingController();
  final nrcRegex = RegExp(r'^\d{6}/\d{2}/\d{1}$');

  final TextEditingController email = TextEditingController();
  final TextEditingController username = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController passwordMatcher = TextEditingController();

  final TextEditingController phonenumber = TextEditingController();

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



      RegisterModel regMod = RegisterModel(imageUrl, about.text.trim(), email: email.text.trim(), password: passwordController.text.trim(), fname: first_name.text.trim(), lname: last_name.text.trim(), nrcc: nrc.text.trim(), number: int.parse(phonenumber.text.trim()), userName: username.text.trim());

      regMod.registerUser();
      setState(() {
        isPosted = true;
      });

      Fluttertoast.showToast(msg: 'Registration Successful', gravity: ToastGravity.BOTTOM);




      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pushNamedAndRemoveUntil('login', (Route<dynamic> route) => false);


    }
  }


  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


   return Scaffold(


     body: SingleChildScrollView(
       child: Column(


         children: [
           Text('Register below with your details!'),

           MyTextField(controller: first_name, hintText: 'First Name', obscureText: false),
           SizedBox(height: 10,),
           MyTextField(controller: last_name, hintText: 'Last Name', obscureText: false),
           SizedBox(height: 10,),

           MyTextField(controller: username, hintText: 'User Name', obscureText: false),
           SizedBox(height: 10,),

           MyTextField(controller: nrc, hintText: 'NRC Number', obscureText: false,

             validator: (value){
               if(!nrcRegex.hasMatch(value)){
                 return 'Please enter a valid NRC number';
               }
             },),
           SizedBox(height: 10,),
           MyTextField(controller: phonenumber, hintText: 'Phone Number', obscureText: false),


           //For the email
           const SizedBox(height: 10,),
           MyTextField(controller: email, hintText: 'Email',
               validator: (value){
                 if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)){
                   return 'Please enter a valid email Address';
                 }
               },
               obscureText: false),

           SizedBox(height: 10,),
           MyTextField(controller: passwordController, hintText: 'Password',
               validator: (value){
             if(value.length < 6){
                   return 'Password should be at least 6 characters';
                 }
               },
               obscureText: true),
           SizedBox(height: 10,),SizedBox(height: 10,),

           MyTextField(controller: passwordMatcher, hintText: 'Confirm Password',
               validator: (value){
                 if(value.length < 6){
                   return 'Password should be at least 6 characters';
                 }
                 else if(value != passwordController.text.trim()

                 ){

                   return 'Passwords don\'t match';
                 }
               },
               obscureText: true),




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
