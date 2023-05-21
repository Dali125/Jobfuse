import 'package:animate_do/animate_do.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobfuse/ui/components/ui-rands/mt_textfield.dart';
import 'package:jobfuse/ui/components/ui-rands/my_button.dart';


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
  int activeStep = 0;
  int upperBound = 7;
  double changers = 18;
  double unchangers = 18;


  List<String> options = [
    'Software Development',
    'Data Analysis',
    'Digital Marketing',
    'Graphic Design',
    'Content Writing and Copywriting',
    'Virtual Assistance',
    'Accounting and Bookkeeping',
    'Customer Support',
    'Online Teaching and Tutoring',
    'Project Management',
    'Construction',
    'Landscape',
    'Mechanical',
    'Electrical',
    'Plumbing',
    'HVAC',
    'Carpentry',
    'Painting',
    'Roofing',
    'Welding',
    'Masonry',
    'Landscaping and Gardening',
    'Security Systems',
    'Flooring',
  ];

  List<String> userInterests = [];



  final _formKey = GlobalKey<FormState>();


  //number 1
  final TextEditingController last_name = TextEditingController();

  final TextEditingController first_name = TextEditingController();

  //The Nrc 9data Stuff
  final TextEditingController nrc = TextEditingController();
  final nrcRegex = RegExp(r'^\d{6}/\d{2}/\d{1}$');

  //number 0
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

    showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return const CupertinoAlertDialog(
            title: Text('Processing'),
            content:  SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Please wait...'),
                  SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator()), // add a progress indicator
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




      RegisterModel regMod = RegisterModel(imageUrl, about.text.trim(),userInterests, email: email.text.trim(), password: passwordController.text.trim(), fname: first_name.text.trim(), lname: last_name.text.trim(), nrcc: nrc.text.trim(), number: int.parse(phonenumber.text.trim()), userName: username.text.trim());

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

     appBar: AppBar(),

     body: Container(
       child: Form(
         key:_formKey,
         autovalidateMode: AutovalidateMode.always,
         child: Column(


          children: [

            NumberStepper(
              activeStepBorderColor: AppColors.splashColor,
              activeStepColor: AppColors.logColor,
              numbers: const [
                1,
                2,
                3,
                4,
                5,
                6,
                7,
                8
              ],

              // activeStep property set to activeStep variable defined above.
              activeStep: activeStep,

              // This ensures step-tapping updates the activeStep.
              onStepReached: (index) {
                setState(() {
                  activeStep = index;
                });
              },
            ),

            Expanded(
                child: stepWidgets()

            ),
          ],

         ),
       ),
     ),

   );
  }
  Widget stepWidgets(){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    switch(activeStep){

      case 1:
        return Container(
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30,),

              FadeInUp(
                delay: Duration(milliseconds: 200),
                child: Padding( 
                  padding: const EdgeInsets.all(25.0),
                  child: FadeInUp(child: TextGuide(text:'Tell us more about Yourself', fontSize: 22, padding: 1,)),
                ),
              ),
              SizedBox(height: 15,),
              FadeInUp(
                  delay: const Duration(milliseconds: 250),
                  child: Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: FadeInUp(
                    delay: Duration(milliseconds: 250),
                    child: TextGuide(text:'First Name', fontSize: 20, padding: 1,)),
              )),
              SizedBox(height: 10,),

              Expanded(child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  FadeInUp(
                      delay: const Duration(milliseconds: 300),
                      child: MyTextField(controller: first_name, hintText: 'First Name', obscureText: false)),

                  const SizedBox(height: 10,),
                  FadeInUp(
                      delay: const Duration(milliseconds: 350),
                      child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: TextGuide(text:'Last Name', fontSize: 20, padding: 1,),
                  )),
                   FadeInUp(
                       delay: const Duration(milliseconds: 400),
                       child: MyTextField(controller: last_name, hintText: 'Last Name', obscureText: false)),
                ],
              )),




              MyButton(onTap: (){

                if (activeStep < upperBound) {
                  setState(() {
                    activeStep++;
                  });
                }

              }, buttonText: 'Continue'),
              SizedBox(height: 20,)
            ],
          ),
        );
//The budget goes here
      case 2:
        return SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 30,),

                FadeInUp(
                  delay: Duration(milliseconds: 200),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: FadeInUp(child: TextGuide(text:'We just need a bit more info', fontSize: 22, padding: 1,)),
                  ),
                ),
                SizedBox(height: 15,),
                FadeInUp(
                    delay: const Duration(milliseconds: 250),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: FadeInUp(
                          delay: Duration(milliseconds: 250),
                          child: TextGuide(text:'NRC Number', fontSize: 20, padding: 1,)),
                    )),
                SizedBox(height: 10,),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    FadeInUp(
                        delay: const Duration(milliseconds: 300),
                        child: MyTextField(controller: nrc, hintText: 'NRC Number', obscureText: false)),

                    const SizedBox(height: 10,),
                    FadeInUp(
                        delay: const Duration(milliseconds: 350),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: TextGuide(text:'Phone Number', fontSize: 20, padding: 1,),
                        )),
                    FadeInUp(
                        delay: const Duration(milliseconds: 400),
                        child: MyTextField(controller: phonenumber, hintText: 'Phone Number', obscureText: false)),
                  ],
                ),


                SizedBox(height: 80,),


                MyButton(onTap: (){

                  if (activeStep < upperBound) {
                    setState(() {
                      activeStep++;
                    });
                  }

                }, buttonText: 'Continue'),
                SizedBox(height: 20,)
              ],
            ),
          ),
        );
//Expeience Level goes here
      case 3:
        return SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 30,),

                FadeInUp(
                  delay: Duration(milliseconds: 200),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: FadeInUp(child: TextGuide(text:'Stand out from the crowd, with a smile', fontSize: 22, padding: 1,)),
                  ),
                ),
                SizedBox(height: 15,),

                Center(child: TextGuide(fontSize: 18, text: 'Choose a profile picture', padding: 1)),

                Center(
                  child: FadeInDown(child: _image != null ?
                  CircleAvatar(
                      radius: 100,
                      child: Image.file(_image!)) : Image.network('https://www.freeiconspng.com/img/23485')

                  ),
                ),
                SizedBox(height: 10,),
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




                SizedBox(height: 80,),


                MyButton(onTap: (){

                  if (activeStep < upperBound) {
                    setState(() {
                      activeStep++;
                    });
                  }

                }, buttonText: 'Continue'),
                SizedBox(height: 20,)
              ],
            ),
          ),
        );

    //Project Duration
      case 4:
        return Container(
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30,),

              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: FadeInUp(child: TextGuide(text:'Lets Secure your account', fontSize: 22, padding: 1,)),
                ),
              ),
              SizedBox(height: 15,),
              FadeInUp(
                  delay: const Duration(milliseconds: 250),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: FadeInUp(
                        delay: Duration(milliseconds: 250),
                        child: TextGuide(text:'Password', fontSize: 20, padding: 1,)),
                  )),
              SizedBox(height: 10,),

              Expanded(child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  FadeInUp(
                      delay: const Duration(milliseconds: 300),
                      child: MyTextField(controller: passwordController, hintText: 'Password', obscureText: true)),

                  const SizedBox(height: 10,),
                  FadeInUp(
                      delay: const Duration(milliseconds: 350),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: TextGuide(text:'Confirm Password', fontSize: 20, padding: 1,),
                      )),
                  FadeInUp(
                      delay: const Duration(milliseconds: 400),
                      child: MyTextField(controller: passwordMatcher, hintText: 'Confirm', obscureText: true)),
                ],
              )),




              MyButton(onTap: (){

                if (activeStep < upperBound) {
                  setState(() {
                    activeStep++;
                  });
                }

              }, buttonText: 'Continue'),
              const SizedBox(height: 20,)
            ],
          ),
        );

    //Project Description
      case 5:
        return ListView.builder(
          itemCount: options.length + 2,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'What are you Interested in? Choose below(Maximum of 10)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              );
            }
            else if (index == options.length + 1) {
              return MyButton(onTap: (){


                if (activeStep < upperBound) {
                  setState(() {
                    activeStep++;
                  });
                }


              }, buttonText: 'Continue');}
            else {
              String option = options[index - 1];
              return CheckboxListTile(
                title: Text(option),
                value: userInterests.contains(option),
                onChanged: (bool? value) {
                  setState(() {
                    if (value != null && value) {
                      userInterests.add(option);
                    } else {
                      userInterests.remove(option);
                    }
                  });
                },
              );
            }
          },
        );


    //post summary
      case 6:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [



          TextGuide(fontSize: 20, text: 'One more thing before you go', padding: 20),
          SizedBox(height: 20,),

          TextGuide(fontSize: 18, text: 'Username', padding: 20),
          MyTextField(controller: username, hintText: 'Username', obscureText: false),
            SizedBox(height: 20,),
            TextGuide(fontSize: 18, text: 'Username', padding: 20),
          Expanded(child: MyTextField(controller: about, hintText: 'A short description about you', obscureText: false)),
          MyButton(onTap: (){


            if (activeStep < upperBound) {
              setState(() {
                activeStep++;
              });
            }
            print(userInterests.length);

          }, buttonText: 'Continue')
        ],);


    //post summary
      case 7:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            FadeInLeft(
                delay: Duration(milliseconds: 200),
                child: TextGuide(fontSize: 30, text: 'Finalize', padding: 15)),



            Center(
              child: FadeInDown(
                  delay: Duration(milliseconds: 250),
                  child:  CircleAvatar(
                  radius: 60,
                  child: Image.file(_image!))


              ),
            ),  
            FadeInUp(
                delay: Duration(milliseconds: 300),
                child: ListTile(leading:  Text('First Name', style: TextStyle(fontSize:unchangers, fontWeight: FontWeight.normal),),trailing: Text(first_name.text.toString(), style: TextStyle(fontSize: changers, fontWeight: FontWeight.bold),))),
            FadeInUp(
                delay: Duration(milliseconds: 350),
                child: ListTile(leading:  Text('Last Name', style: TextStyle(fontSize: unchangers),),trailing: Text(last_name.text.toString(), style: TextStyle(fontSize: changers, fontWeight: FontWeight.bold),),)),
            FadeInUp(
                delay: Duration(milliseconds: 400),
                child: ListTile(leading:  Text('email', style: TextStyle(fontSize: unchangers),),trailing: Text(email.text.toString(), style: TextStyle(fontSize: changers, fontWeight: FontWeight.bold),),)),
            FadeInUp(
                delay: Duration(milliseconds: 450),
                child: ListTile(leading:  Text('Username', style: TextStyle(fontSize: unchangers),),trailing: Text(username.text.toString(), style: TextStyle(fontSize: changers, fontWeight: FontWeight.bold),),)),
            FadeInUp(
                delay: Duration(milliseconds: 500),
                child: ListTile(leading:  Text('Phone Number', style: TextStyle(fontSize: unchangers),),trailing: Text(phonenumber.text.toString(), style: TextStyle(fontSize: changers, fontWeight: FontWeight.bold),),)),
            FadeInUp(
                delay: Duration(milliseconds: 550),
                child: ListTile(leading:  Text('NRC NUMBER', style: TextStyle(fontSize: unchangers),overflow: TextOverflow.clip,),trailing: Text(nrc.text.toString(),maxLines: 1, style: TextStyle(fontSize: changers, fontWeight: FontWeight.bold),),)),



            FadeInUp(
              delay: Duration(milliseconds: 600),
              child: MyButton(onTap: (){

                _submitForm();


              }, buttonText: 'Submit and Register'),
            )
          ],);



    //What to show when selecting the task type
      default:
        return Container(
          height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30,),

              Padding(
                padding: const EdgeInsets.all(25.0),
                child: FadeInUp(child: TextGuide(text:'Let\'s get started', fontSize: 25, padding: 1,)),
              ),
              SizedBox(height: 15,),
              FadeInUp(child: Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: TextGuide(text:'Email', fontSize: 20, padding: 1,),
              )),
              SizedBox(height: 10,),
              Expanded(child: MyTextField(controller: email, hintText: 'Email', obscureText: false)),


              MyButton(onTap: (){

                if (activeStep < upperBound) {
                  setState(() {
                    activeStep++;
                  });
                }

              }, buttonText: 'Continue'),
              const SizedBox(height: 20,)
            ],
          ),
        );



    }


  }
}
