import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:phone_auth/Pages/Verify%20Email/email_verify.dart';
import 'package:phone_auth/Pages/home.dart';
import 'package:phone_auth/Pages/loginsignup.dart';
import 'package:phone_auth/Pages/signup.dart';
import 'package:phone_auth/email_verify.dart';
// import 'package:phone_auth/Pages/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: const Loginsignup(),
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), 
      builder: (context,snapshot){
        if (snapshot.hasData){
          return  Home();
        }
        else{
          return const Loginsignup();
        }

      }
      ),
    );
  }
}
