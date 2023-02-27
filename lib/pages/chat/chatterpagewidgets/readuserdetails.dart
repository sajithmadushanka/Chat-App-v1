import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserDetails extends StatelessWidget {
  final String documetId;
  UserDetails({super.key, required this.documetId});

  // get collection
  CollectionReference user = FirebaseFirestore.instance.collection('User');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: user.doc(documetId).get(), // get user details who has documetId
      builder: (context, snapshot) {
        try {
          if (snapshot.connectionState == ConnectionState.done) {
            Map data =
                snapshot.data!.data() as Map; // specific user data add as a Map

            return Text(
              // return textwiget to list of user page
              '${data['user_name']} '

              /// map name and key
              '${data['age']}'
              ' years old',
              style: const TextStyle(fontSize: 20),
            );
          }
        } catch (e) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(e.toString()),
              );
            },
          );
        }

        return const Text(
            'loading'); // show lodaing animation untill load backend data
      },
    );
  }
}
