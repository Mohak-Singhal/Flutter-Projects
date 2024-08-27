import 'package:flutter/material.dart';
import 'package:phone_auth/Pages/Services/authentication.dart';
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
  bool isLoading = false;

  void despose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
  }

  void signUpUser() async {
    String res = await AuthServicews().signUpUser(
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
              // width: double.infinity,
              height: height / 3.7,
              child: Image.network("https://img.freepik.com/free-vector/sign-up-concept-illustration_114360-7965.jpg?ga=GA1.1.984965425.1724765859&semt=ais_hybrid"),
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
            Buttons(onTap: signUpUser, text: "Sign Up"),
            SizedBox(
              height: height / 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an Account?",
                  style: TextStyle(fontSize: 16),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.blue),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
