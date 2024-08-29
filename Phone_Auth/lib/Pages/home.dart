import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:phone_auth/Pages/Widget/buttons.dart';
import 'package:phone_auth/Pages/login%20with%20google/googlelogin.dart';
import 'package:phone_auth/Pages/loginsignup.dart';

class Home extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> signOut() async {
  await auth.signOut();
}
   Home({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Congratulations\n You have been logged in ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Buttons(
                onTap: () async {
                  await FirebaseServicesGoogle().googleSignOut();

                  await signOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const Loginsignup(),
                    ),
                  );
                },
                text: "Log Out"),
                Image.network("${FirebaseAuth.instance.currentUser!.photoURL}"),
                Text("${FirebaseAuth.instance.currentUser!.email}"),
                Text("${FirebaseAuth.instance.currentUser!.displayName}"),

          ],
        ),
      ),
    );
  }
}
