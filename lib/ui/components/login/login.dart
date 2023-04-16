import 'package:flutter/material.dart';
import 'package:jobfuse/logic/models/login_model.dart';
import 'package:jobfuse/ui/colors/colors.dart';
import 'package:rive/rive.dart';

import '../ui-rands/mt_textfield.dart';
import '../ui-rands/my_button.dart';
import 'login_process.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.logColor,


        body: SingleChildScrollView(
          child: Column(
            children: [


              const SizedBox(height: 150),
              const Icon(Icons.add,size: 100,),


              Text(
                'Welcome back you\'ve been missed!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),


              const SizedBox(height: 25),

              // username textfield
              MyTextField(
                controller: usernameController,
                hintText: 'Email',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
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
              MyButton(
                
                onTap: (){
                  LoginModel logmod = LoginModel(email: usernameController.text.trim(), password: passwordController.text.trim());
                  logmod.SignIn();
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Confirmer()));


                }, buttonText: 'Sign in',
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
                const Text(
                  'Register now',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),






            ],
          )

            ]
      ),
        ),
      )
    );
  }
}
