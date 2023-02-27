import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../screens/list_of_users.dart';

class MySignBtn extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailcolroller;
  final TextEditingController passwordcontroler;
  const MySignBtn(
      {super.key,
      required this.formKey,
      required this.emailcolroller,
      required this.passwordcontroler});

  // check validations username and password with firebase // formKey.currentState!.validate()
  void validation(context) async {
    if (formKey.currentState!.validate()) {
      // if validation was success then can be signin
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailcolroller.text.trim(),
            password: passwordcontroler.text.trim());
        // navigate the Users List page
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const MyuserPage(),
        ));
      } catch (e) {
        // if not valided user details then show error msg as dailogbox
        showdialog(context, e.toString());
      }
    }
  }

// show error message box got from signin
  void showdialog(context, msg) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(msg),
          );
        });
  }

  // @override // sispose the input contriller/ that for memory leak
  // void dispose() {
  //   emailcolroller.dispose();
  //   passwordcontroler.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          validation(context);
        },
        child: Text(
          "Login",
          style: TextStyle(
              color: Theme.of(context).primaryColorLight, fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
