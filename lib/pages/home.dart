import 'package:flutter/material.dart';

import 'screens/rg_widgets.dart';
import 'screens/loginpage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool showscreen = true; // sign in page
  // switching method among the login and signin
  void taggleScreen() {
    setState(() {
      showscreen = !showscreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    // swich with login page and register page(I have not account / I have an account)
    if (showscreen) {
      return SignInPage(
        taggleScreen: taggleScreen,
      );
    } else {
      return SignUpPage(
        taggleScreen: taggleScreen,
      );
    }
  }
}
