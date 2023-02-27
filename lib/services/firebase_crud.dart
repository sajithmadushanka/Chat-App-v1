import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// ignore: non_constant_identifier_names
final CollectionReference _Collection = _firestore.collection('User');

class FirebaseCrud {
//CRUD method here
// create mthode ----------------------------------
  static Future<Response> addUser({
    required String name,
    required int age,
    required String email,
    required String password,
  }) //---------------------------- end of user static model

  async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password); // user authentication

    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "user_name": name,
      "age": age,
      "email": email
    };

    await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}
