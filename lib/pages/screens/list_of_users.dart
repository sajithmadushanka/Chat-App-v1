import 'package:chatapp/pages/chat/chatpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../chat/chatterpagewidgets/chattername.dart';

class MyuserPage extends StatefulWidget {
  const MyuserPage({super.key});

  @override
  State<MyuserPage> createState() => _MyuserPageState();
}

class _MyuserPageState extends State<MyuserPage> {
  // get detail of current logged user
  final user = FirebaseAuth.instance.currentUser;

  // store doc ids
  List<String> docIDs = [];
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('User')
        .get()
        // ignore: avoid_function_literals_in_foreach_calls
        .then((snapshot) => snapshot.docs.forEach((docs) {
              //----- get email from docs----
              var email = docs.get('email');
              // add docids to the list without current logged user
              if (email != user!.email) {
                docIDs.add(docs.id);
              }
              // ad eche doIDs to the list
            }));
  }

  //-------------------------------
  List<String> userEmailList = [];

  Future getUserEmail() async {
    final collectionSnapshot =
        await FirebaseFirestore.instance.collection('User').get();
    for (var doc in collectionSnapshot.docs) {
      if (doc.data().containsKey('email')) {
        var email = doc['email'] as String?;
        if (email != null) {
          if (user!.email != email) {
            userEmailList.add(email);
          }
        }
      }
    }
  }

  Future getDetails() async {
    await getDocId();
  }

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        title: Text(
          "${user!.email}", // show email of current user
          style: const TextStyle(fontSize: 20),
        ),
        actions: [
          GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
              child: const Icon(Icons.logout))
        ],
        leading: IconButton(
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => const MyUpdate(),
              // ));
            },
            icon: const Icon(Icons.update)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder(
                future: getUserEmail(), // future function
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: docIDs.length, // length of docIds list
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: ChatterName(chatterDocId: docIDs[index]),
                          leading: const Icon(Icons.account_box_rounded),
                          trailing: const Icon(Icons.chat),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: const BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 26, 29, 172)),
                          ),
                          tileColor: Colors.white,
                          selectedTileColor: Colors.deepPurple,
                          // return text widget with include username and age

                          // when someone clicked the list tile then navigate to the chatting page
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Mychatpage(
                                docId: docIDs[index],
                                receiverEmail: userEmailList.isNotEmpty
                                    ? userEmailList[index]
                                    : null,
                              ), // send docId for identify the logged user
                            ));
                          },
                        ),
                      );
                    }),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
