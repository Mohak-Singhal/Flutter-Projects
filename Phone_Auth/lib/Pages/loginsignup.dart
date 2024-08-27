import 'package:flutter/material.dart';
import 'package:phone_auth/Pages/ForgotPassword/forgot_password.dart';
import 'package:phone_auth/Pages/Widget/buttons.dart';
import 'package:phone_auth/Pages/Widget/snackbar.dart';
import 'package:phone_auth/Pages/Widget/textfields.dart';
import 'package:phone_auth/Pages/home.dart';
import 'package:phone_auth/Pages/login%20with%20google/googlelogin.dart';
import 'package:phone_auth/Pages/phoneauthentication/phoneauthentication.dart';
import 'package:phone_auth/Pages/signup.dart';

import 'Services/authentication.dart';

class Loginsignup extends StatefulWidget {
  const Loginsignup({super.key});

  @override
  State<Loginsignup> createState() => _LoginsignupState();
}

class _LoginsignupState extends State<Loginsignup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void despose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUsers() async {
    String res = await AuthServicews().loginUser(
      email: emailController.text,
      password: passwordController.text,
    );

    if (res == "success") {
      setState(() {
        isLoading = true;
      });

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Home(),
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
              width: double.infinity,
              height: height / 3.8,
              child: Image.network("https://img.freepik.com/free-vector/mobile-login-concept-illustration_114360-83.jpg?size=338&ext=jpg&ga=GA1.1.1413502914.1724630400&semt=ais_hybrid"),
            ),
            Textfields(
                textEditingController: emailController,
                hintText: "Email ID",
                icon: Icons.email),
            Textfields(
                isPass: true,
                textEditingController: passwordController,
                hintText: "Password",
                icon: Icons.lock),
            const ForgotPassword(),
            Buttons(
              onTap: loginUsers,
              text: "Log In",
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    color: Colors.black,
                  ),
                ),
                const Text("  or  "),
                Expanded(
                  child: Container(
                    height: 1,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
         Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 2),
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () async {
                  await FirebaseServicesGoogle().signInWithGoogle();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:7),
                      child: Image.network(
                        "https://ouch-cdn2.icons8.com/VGHyfDgzIiyEwg3RIll1nYupfj653vnEPRLr0AeoJ8g/rs:fit:456:456/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvODg2/LzRjNzU2YThjLTQx/MjgtNGZlZS04MDNl/LTAwMTM0YzEwOTMy/Ny5wbmc.png",
                        height: 30,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Continue with Google",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const PhoneAuthentication(),
            SizedBox(
              // height: height / 15,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 60,),
              child: Row(
                children: [
                  const Text(
                    "Don't have an Account?",
                    style: TextStyle(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Signup(),
                        ),
                      );
                    },
                    child: const Text(
                      " SignUp",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.blue),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
