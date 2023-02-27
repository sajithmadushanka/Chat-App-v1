import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChatterName extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final chatterDocId;

  ChatterName({
    super.key,
    required this.chatterDocId,
  });

  CollectionReference user = FirebaseFirestore.instance.collection('User');
  final currentuser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: user.doc(chatterDocId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          String username = data['user_name'];

          return Text(
            username,
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
