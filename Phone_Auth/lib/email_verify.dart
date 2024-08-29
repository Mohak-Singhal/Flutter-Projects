import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EmailVerify extends StatefulWidget {
  const EmailVerify({super.key});

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  TextEditingController emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  // Added: Email validation regex
  final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

  Future<void> resendVerificationEmail(String email) async {
    try {
      // Sending verification email
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    } catch (e) {
      // Handle errors here
      print('Error sending email verification: $e');
      throw e; // Rethrow to handle in the button press
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Align(
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: () {
            myDialogBox(context);
          },
          child: const Text(
            "Email Verify",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }

  void myDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    const Text(
                      "Email Verification",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "To resend the email verification, please enter your email address below.",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    width: 240,
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        hintText: "Enter Email Address",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final email = emailController.text.trim();

                    if (email.isEmpty) {
                      // Show an error dialog if the email is empty
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text('Please enter an email address.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else if (!emailRegex.hasMatch(email)) {
                      // Added: Show an error dialog if the email format is invalid
                      showDialog(
                        
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text('Please enter a valid email address.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      try {
                        // Call the resendVerificationEmail method with the entered email
                        await resendVerificationEmail(email);

                        // Show a success dialog indicating that the email has been sent
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Email Sent'),
                              content: const Text('A verification email has been sent to your email address.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } catch (e) {
                        // Show an error dialog if there was a problem sending the email
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: const Text('There was an error sending the email. Please try again.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                  child: const Text("Resend Email"),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
