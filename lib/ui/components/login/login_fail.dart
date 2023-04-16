import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../logic/models/login_model.dart';
import '../../colors/colors.dart';
import '../../register/register_page.dart';
import 'login_process.dart';




class LoginFail extends StatefulWidget {
  const LoginFail({Key? key}) : super(key: key);

  @override
  State<LoginFail> createState() => _LoginFailState();
}

class _LoginFailState extends State<LoginFail> {
  //Email and password
  final TextEditingController _email = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    //Size of Screen
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(

      backgroundColor: AppColors.logColor,

      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            height: height / 3.5,
            width: width,
            color: AppColors.splashColor,
          ),
          const SizedBox(
            height: 40,
          ),

          //Login Button Here
          Column(
            children: [
              const Text('Sign in'),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        labelText: 'Email/Phone',
                        errorText: 'Email or password not valid',
                        hintText: 'Enter valid mail id as abc@gmail.com'),
                    controller: _email,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    labelText: 'Password',
                    errorText: 'email or password not valid',
                    hintText: 'Enter your secure password',
                  ),
                  controller: _passwordController,
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: ElevatedButton(
                  onPressed: () {
                    LoginModel loginModel = LoginModel(
                        email: _email.text.trim(),
                        password: _passwordController.text.trim());
                    loginModel.SignIn();

                    Navigator.push(context, PageTransition(child: Confirmer(), type: PageTransitionType.fade));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.splashColor,
                    elevation: 8,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Not a member?'),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register()));
                    },
                    child: Text(
                      'Register Here',
                      style: TextStyle(color: AppColors.splashColor),
                    ),
                  )
                ],
              )
            ],
          )
        ]),
      ),
    );
  }
}
