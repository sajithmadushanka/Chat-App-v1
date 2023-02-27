import 'package:chatapp/pages/componets/textfiled.dart';
import 'package:flutter/material.dart';

import '../componets/signbtn.dart';



// ignore: must_be_immutable
class SignInPage extends StatelessWidget {
  VoidCallback taggleScreen;
  SignInPage({super.key, required this.taggleScreen});

  // input controller
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

//------------------ form control key ----------------------------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final emailField =
        MyTextFiled(textfieldName: 'email', controller: mailController);
    final passwordField =
        MyTextFiled(textfieldName: 'password', controller: passwordController);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(title: const Text('baddy-chaty')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
                key: _formKey,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          emailField,
                          const SizedBox(height: 25.0),
                          passwordField,
                          const SizedBox(height: 25.0),
                          MySignBtn(
                              formKey: _formKey,
                              emailcolroller: mailController,
                              passwordcontroler: passwordController),
                          const SizedBox(height: 25.0),
                          GestureDetector(
                              onTap: taggleScreen, // calback function run in login page
                              child: const Text('I have not an account'))
                        ])))
          ],
        ),
      ),
    );
  }
}
