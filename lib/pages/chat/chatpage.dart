import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chatterpagewidgets/msgshowtext.dart';
import 'chatterpagewidgets/chattername.dart';
import 'chatterpagewidgets/newmsg.dart';

class Mychatpage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final receiverEmail;

  // ignore: prefer_typing_uninitialized_variables
  final docId;
  const Mychatpage({Key? key, required this.receiverEmail, required this.docId})
      : super(key: key);

  @override
  State<Mychatpage> createState() => _MychatpageState();
}

class _MychatpageState extends State<Mychatpage> {
  CollectionReference user = FirebaseFirestore.instance.collection('User');

  final currentuser = FirebaseAuth.instance.currentUser!;
  TextEditingController controllerText = TextEditingController();

  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentuser.email.toString()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // show chatter name ---------------------------
            ChatterName(
              chatterDocId: widget.docId,
            ),
            const SizedBox(height: 20),
            // show streamdata-------------------------

            MsgShowText(
              senderEmail: currentUser!.email.toString(),
              receiverEmail: widget.receiverEmail,
            ),

            // textfeild ------------------------------------------------
            const SizedBox(height: 20),

            NewMessageWidget(
                senderEmail: currentUser!.email,
                receiverEmail: widget.receiverEmail)
          ],
        ),
      ),
    );
  }
}
