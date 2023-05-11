import 'package:animate_do/animate_do.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobfuse/logic/models/login_model.dart';
import 'package:jobfuse/ui/colors/colors.dart';
import 'package:jobfuse/ui/register/register_page.dart';
import '../ui-rands/mt_textfield.dart';
import '../ui-rands/my_button.dart';
import 'login_process.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {


  final _formKey = GlobalKey<FormState>();
  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();





 void initState(){


   super.initState();



  }




  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    bool _validateAndSave(){
      final form = _formKey.currentState;
      if(form!.validate()){

        return true;
      }
      return false;
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.logColor,


        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [


                const SizedBox(height: 150),
                const Icon(Icons.add,size: 100,),


                FadeInUp(
                  child: Text(
                    'Welcome back you\'ve been missed!',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
                ),


                const SizedBox(height: 25),

                // username text-field
                FadeInLeft(
                  child: MyTextField(
                    controller: usernameController,
                    hintText: 'Email',
                    obscureText: false,
                    validator: (value){
                      if(value.isEmpty){
                        return 'Please enter your Email';

                      }else if(!EmailValidator.validate(value)){

                        return 'Please provide a valid email';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 10),

                // password textfield
                FadeInRight(
                  child: MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    validator: (value){

                      if(value.isEmpty){

                        return 'Please enter your password';

                      }else if(value.length < 6){

                        return 'Password should be at least 6 characters';
                      }
                    },
                  ),
                ),


                const SizedBox(height: 10),
                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // sign in button
                FadeInUp(
                  child: MyButton(

                    onTap: (){

                      if(_validateAndSave()){


                        LoginModel logmod = LoginModel(email: usernameController.text.trim(), password: passwordController.text.trim());
                        logmod.SignIn();
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => const Confirmer()));
                        Fluttertoast.showToast(msg: 'Login Successful');
                      }


                    }, buttonText: 'Sign in',
                  ),
                ),

              const SizedBox(
                height: 10,
              ),
              //Register Now Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(


                    child: const Text(
                      'Register now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    onTap: (){


                      Navigator.push(context, MaterialPageRoute(builder: (context)
                      => Register()));
                    },
                  ),






              ],
            )

              ]
      ),
          ),
        ),
      )
    );
  }
}


