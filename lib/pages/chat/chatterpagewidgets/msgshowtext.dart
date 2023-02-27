import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MsgShowText extends StatelessWidget {
  final String senderEmail;
  final String receiverEmail;

  MsgShowText(
      {super.key, required this.senderEmail, required this.receiverEmail});

  final currentuser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> senderMessagesStream = FirebaseFirestore.instance
        .collection('messages')
        .where('senderEmail', isEqualTo: senderEmail)
        .where('receiverEmail', isEqualTo: receiverEmail)
        .orderBy('timestamp', descending: true)
        .snapshots();

    Stream<QuerySnapshot> receiverMessagesStream = FirebaseFirestore.instance
        .collection('messages')
        .where('senderEmail', isEqualTo: receiverEmail)
        .where('receiverEmail', isEqualTo: senderEmail)
        .orderBy('timestamp', descending: true)
        .snapshots();

    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: senderMessagesStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return const Text('Loading messages...');
          }
          List<DocumentSnapshot> senderMessages = snapshot.data!.docs;

          return StreamBuilder<QuerySnapshot>(
            stream: receiverMessagesStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (!snapshot.hasData) {
                return const Text('Loading messages...');
              }
              List<DocumentSnapshot> receiverMessages = snapshot.data!.docs;

              // concatenate messages from the two streams
              List<DocumentSnapshot> allMessages = List.from(senderMessages)
                ..addAll(receiverMessages);
              allMessages.sort((b, a) => (a['timestamp'] as Timestamp)
                  .compareTo(b['timestamp'] as Timestamp));

              return allMessages.isEmpty
                  ? const Text(
                      'Say Hi :)',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  : ListView.builder(
                      reverse: true,
                      itemCount: allMessages.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map<String, dynamic> data =
                            allMessages[index].data() as Map<String, dynamic>;
                        bool isSentMessage =
                            data['senderEmail'] == currentuser.email;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10.0),
                          decoration: BoxDecoration(
                            color: isSentMessage ? Colors.blue : Colors.grey,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 6.0,
                          ),
                          child: Align(
                            alignment: isSentMessage
                                ? Alignment.topRight
                                : Alignment.topLeft,
                            child: Text(
                              data['messageContent'],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    );
            },
          );
        },
      ),
    );
  }
}
