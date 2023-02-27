import 'package:flutter/material.dart';

import '../../services/firebase_crud.dart';
import '../screens/list_of_users.dart';

class MySaveBtn extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController ageController;
  final TextEditingController mailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  const MySaveBtn(
      {super.key,
      required this.nameController,
      required this.ageController,
      required this.mailController,
      required this.passwordController,
      required this.formKey});
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            try {
              var response = await FirebaseCrud.addUser(
                  name: nameController.text,
                  age: int.parse(ageController.text),
                  email: mailController.text.trim(),
                  password: passwordController.text.trim());
              if (response.code != 200) {
                // ignore: use_build_context_synchronously
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(response.message.toString()),
                      );
                    });
              } else {
                // ignore: use_build_context_synchronously
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(response.message.toString()),
                      );
                    });
                // ignore: use_build_context_synchronously
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MyuserPage()));
              }
            } catch (e) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(e.toString()),
                    );
                  });
            }
          }
        },
        child: Text(
          "Save",
          style: TextStyle(color: Theme.of(context).primaryColorLight),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
