import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

import '../../logic/models/register_model.dart';
import '../colors/colors.dart';
import '../components/home/home.dart';
import '../components/login/login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _last_name = TextEditingController();

  final TextEditingController _first_name = TextEditingController();

  final TextEditingController _nrc = TextEditingController();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _passwordMatcher = TextEditingController();

  final TextEditingController _phonenumber = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _email.dispose();
    _first_name.dispose();
    _nrc.dispose();
    _last_name.dispose();
    _passwordController.dispose();
    _passwordMatcher.dispose();
    _phonenumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'Register',
              style: TextStyle(fontSize: 30),
            ),

            SafeArea(
              //First Name
              child: Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)),
                      labelText: 'First Name',
                      hintText: 'Enter your First Name'),
                  controller: _first_name,
                ),
              ),
            ),

            //Last Name
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(

                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  labelText: 'Last Name',
                  hintText: 'Enter your Last Name',
                ),
                controller: _last_name,
              ),
            ),
            //UserName
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  labelText: 'User Name',
                  hintText: 'Enter a username',
                ),
                controller: _username,
              ),
            ),
            //NRC
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  labelText: 'ID/NRC number',
                  hintText: 'Enter your NRC',
                ),
                controller: _nrc,
              ),
            ),
            //Phone Number
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  labelText: 'Phone_number',
                  hintText: 'Number Here',
                ),
                controller: _phonenumber,
              ),
            ),
            //Email
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  labelText: 'Email',
                  hintText: 'Ex. abd@something.com',
                ),
                controller: _email,
              ),
            ),
//Password
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  labelText: 'Password',
                  hintText: 'Enter your secure password',
                ),
                controller: _passwordController,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)),
                  labelText: 'Confirm Password',
                  hintText: 'Enter your secure password',
                ),
                controller: _passwordMatcher,
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: ElevatedButton(
                onPressed: () {
                  RegisterModel register = RegisterModel(
                    email: _email.text.trim(),
                    password: _passwordController.text.trim(),
                    fname: _first_name.text.trim(),
                    lname: _last_name.text.trim(),
                    nrcc: _nrc.text.trim(),
                    number: int.parse(_phonenumber.text.trim()),
                    user_name: _username.text.trim(),
                  );
                  register.registerUser();

                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Home()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.splashColor,
                  elevation: 8,
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text(
                    'Login Here',
                    style: TextStyle(color: AppColors.splashColor),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
