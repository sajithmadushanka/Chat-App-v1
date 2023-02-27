import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/messages.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// ignore: non_constant_identifier_names
final CollectionReference _Collection = _firestore.collection('messages');

class MessagesOperations {
// create mthode ----------------------------------
  static Future<Messages> addMessage({
    required String messageContent,
    required String senderEmail,
    required String receiverEmail,
    required Timestamp? timestamp,
    required bool? isRead,
    required String? type,
  }) //---------------------------- end of user static model

  async {
    // user authentication

    Messages messages = Messages();
    DocumentReference documentReferencer = _Collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      'messageContent': messageContent,
      'senderEmail': senderEmail,
      'receiverEmail': receiverEmail,
      'timestamp': timestamp,
      'isRead': isRead,
      'type': type
    };

    await documentReferencer.set(data).whenComplete(() {
      messages.code = 200;
      messages.message = "sent";
    }).catchError((e) {
      messages.code = 500;
      messages.message = e;
    });

    return messages;
  }
}
