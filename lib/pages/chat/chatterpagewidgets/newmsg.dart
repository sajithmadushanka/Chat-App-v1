import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../services/messages.dart';

class NewMessageWidget extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final senderEmail;
  // ignore: prefer_typing_uninitialized_variables
  final receiverEmail;

  NewMessageWidget({required this.senderEmail, required this.receiverEmail})
      // ignore: prefer_const_constructors
      : super(key: Key('11'));

  @override
  // ignore: library_private_types_in_public_api
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final _controller = TextEditingController();
  String message = '';

// send funtion for after user sent message that will store to the firebase
  void sendMessage() async {
    FocusScope.of(context).unfocus();

    String messageContent = message;
    String senderEmail = (widget.senderEmail != null) ? widget.senderEmail : '';
    String receiverEmail = widget.receiverEmail;
    Timestamp timestamp = Timestamp.now(); // get time bynow
    bool isRead = false;
    String type = "text";

    /// send all datas to the sercice messages page with call addMessage static function on Messagesoperation class----
    var response = await MessagesOperations.addMessage(
      messageContent: messageContent,
      senderEmail: senderEmail,
      receiverEmail: receiverEmail,
      timestamp: timestamp,
      isRead: isRead,
      type: type,
    );

    //--------show sent a message after store message to the database -------------------------//

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.message.toString()),
        duration: const Duration(milliseconds: 60),
      ),
    );

    _controller.clear(); // clear text controller
  }

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Expanded(
              //---- then message type textfield -----------------------
              child: TextField(
                controller: _controller,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  labelText: 'Type your message',
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 0),
                    gapPadding: 10,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onChanged: (value) => setState(() {
                  // setState for refresh ui after sent a message
                  message = value;
                }),
              ),
            ),
            const SizedBox(width: 20),

            //------- message send button --------------------
            GestureDetector(
              onTap: message.trim().isEmpty ? null : sendMessage,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: const Icon(Icons.send, color: Colors.white),
              ),
            ),
          ],
        ),
      );
}
