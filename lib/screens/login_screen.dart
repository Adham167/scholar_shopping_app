import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholar_shopping_app/widgets/custom_text_form_field.dart';
import 'package:scholar_shopping_app/widgets/show_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  Future<void> _loginUser() async {
    if (_formkey.currentState!.validate()) return;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: _emailcontroller.text.trim(),
            password: _passwordcontroller.text.trim(),
          );
      ShowMessage(context, "Success");
      Navigator.pushReplacementNamed(context, "/homescreen");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.shopping_bag, color: Colors.blueAccent, size: 60),
                SizedBox(height: 16),
                Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 12),
                Opacity(
                  opacity: 0.5,
                  child: Text(
                    "Sign in to continue shopping",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Form(
                  key: _formkey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: _emailcontroller,
                          label: "Email",
                          iconData: Icons.email,
                          textInputType: TextInputType.text,
                        ),
                        SizedBox(height: 8),
                        CustomTextFormField(
                          controller: _passwordcontroller,
                          label: "Password",
                          iconData: Icons.lock,
                          obsecureText: true,
                        ),
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () => _loginUser(),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.blueAccent,
                              ),

                              height: 50,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Comming soon ........")),
                            );
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ),
                        SizedBox(height: 32),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(color: Colors.grey, thickness: 1),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Text(
                                'OR',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(color: Colors.grey, thickness: 1),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap:
                                () => Navigator.pushReplacementNamed(
                                  context,
                                  "/registerscreen",
                                ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.transparent,
                                border: Border.all(color: Colors.blueAccent),
                              ),

                              height: 50,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  "Create an Account",
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
