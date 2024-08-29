import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:phone_auth/Pages/Services/email_verify.dart';
// import 'package:phone_auth/Pages/Services/authentication.dart';
import 'package:phone_auth/Pages/Widget/buttons.dart';
import 'package:phone_auth/Pages/Widget/snackbar.dart';
import 'package:phone_auth/Pages/Widget/textfields.dart';
import 'package:phone_auth/Pages/home.dart';
import 'package:phone_auth/Pages/loginsignup.dart';



class Signup extends StatefulWidget {
  const Signup({super.key});
  

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;
 


Future<String> signUpUser({
  required String email,
  required String password,
  required String phone,
  required String name,
}) async {
  String res = 'Some Error Occurred';
  try {
    if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty) {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send email verification
      await credential.user?.sendEmailVerification();

      // Save user data to Firestore
      await firestore.collection('users').doc(credential.user!.uid).set({
        "name": name,
        "email": email,
        'uid': credential.user!.uid,
      });

      res = "A verification email has been sent. Please check your email.";
    } else {
      res = "Please fill in all the fields.";
    }
  } catch (e) {
    res = e.toString();
  }
  return res;
}



  

  void despose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
  }
void signUp() async {
    String res = await signUpUser(
        email: emailController.text,
        password: passwordController.text,
        phone: phoneController.text,
        name: nameController.text);

    if (res == "success") {
      setState(() {
        isLoading = true;
      });

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Loginsignup(),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, res);
    }
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              // width: double.infinity,
              height: height / 3.7,
              child: Image.network(
                  "https://img.freepik.com/free-vector/sign-up-concept-illustration_114360-7965.jpg?ga=GA1.1.984965425.1724765859&semt=ais_hybrid"),
            ),
            Textfields(
                textEditingController: nameController,
                hintText: "Name",
                icon: Icons.person),
            Textfields(
                textEditingController: phoneController,
                hintText: "Phone No",
                icon: Icons.phone),
            Textfields(
                textEditingController: emailController,
                hintText: "Email ID",
                icon: Icons.email),
            Textfields(
                textEditingController: passwordController,
                hintText: "Password",
                icon: Icons.lock),
            Buttons(  onTap: signUp, text: "Sign Up"),
            SizedBox(
              height: height / 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an Account?",
                  style: TextStyle(fontSize: 20),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Loginsignup(),
                      ),
                    );
                  },
                  child: const Text(
                    " Login",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blue),
                  ),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
