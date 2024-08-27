import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AuthServicews {
  //for storing data in clod

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  //for authentication
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> signUpUser(
      {required String email,
      required String password,
      required String phone,
      required String name}) async {
    String res = 'Some Error Occured';
    try {
      if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty) {
        UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await firestore.collection('users').doc(credential.user!.uid).set({
          "name": name,
          "email": email,
          'uid': credential.user!.uid,
        });
        res = "success";
      }
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some Error Occured';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (e) {
      return e.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
