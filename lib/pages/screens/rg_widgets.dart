import 'package:chatapp/pages/componets/textfiled.dart';
import 'package:flutter/material.dart';

import '../componets/savebtn.dart';

// ignore: must_be_immutable
class SignUpPage extends StatefulWidget {
  VoidCallback taggleScreen;
  SignUpPage({super.key, required this.taggleScreen});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // controller
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  //-------------------

  @override
  Widget build(BuildContext context) {
    final nameField =
        MyTextFiled(textfieldName: 'Name', controller: nameController);
    final ageField =
        MyTextFiled(textfieldName: 'Age', controller: ageController);
    final emailField =
        MyTextFiled(textfieldName: 'Email', controller: mailController);
    final passwordField =
        MyTextFiled(textfieldName: 'Password', controller: passwordController);

    // ignore: non_constant_identifier_names
    final SaveButon = MySaveBtn(
      nameController: nameController,
      ageController: ageController,
      mailController: mailController,
      passwordController: passwordController,
      formKey: _formKey,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('buddy chatty'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  nameField,
                  const SizedBox(height: 25.0),
                  ageField,
                  const SizedBox(height: 35.0),
                  emailField,
                  const SizedBox(height: 35.0),
                  passwordField,
                  const SizedBox(height: 35.0),
                  SaveButon,
                  const SizedBox(height: 15.0),
                  GestureDetector(
                    onTap: widget.taggleScreen,
                    child: const Text('I have an account'),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
