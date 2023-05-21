import 'package:firebase_auth/firebase_auth.dart';

import '../../ui/components/login/login_fail.dart';

class LoginModel {
  String email;
  String password;

  LoginModel({required this.email, required this.password});

  Future SignIn() async {
    if (email == null && password == null) {
      return LoginFail();
    } else {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);



        
      } on FirebaseAuthException catch (e) {}
    }
  }
}

class LogoutModel {
  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
