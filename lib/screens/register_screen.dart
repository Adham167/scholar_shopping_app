import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:scholar_shopping_app/widgets/custom_text_form_field.dart';
import 'package:scholar_shopping_app/widgets/show_message.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  File? _imageFile;

  final _formkey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _gender;
  bool isLoading = false;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void registerUser() async {
    if (!_formkey.currentState!.validate()) return;
    setState(() {
      isLoading = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

      String uid = userCredential.user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        "mail": _emailController.text.trim(),
        "name": _fullNameController.text.trim(),
        "phone": _phoneNumberController.text.trim(),
        "address": _addressController.text.trim(),
        "password": _passwordController.text.trim(),
        "confirmpassword": _confirmPasswordController.text.trim(),
        "gendre": _gender,
        "isAdmin": false,
      });
      ShowMessage(context, "Success !");
      Navigator.pushReplacementNamed(context, "/loginscreen");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ShowMessage(context, "'The password provided is too weak.'");
      } else if (e.code == 'email-already-in-use') {
        ShowMessage(context, "email already in use");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        title: Text("Register", style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey[300],
                        backgroundImage:
                            _imageFile != null ? FileImage(_imageFile!) : null,
                        child:
                            _imageFile == null
                                ? Icon(
                                  Icons.person,
                                  size: 60,
                                  color: Colors.white,
                                )
                                : null,
                      ),

                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () => _pickImage(),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: _fullNameController,
                          label: "Full Name",
                          iconData: Icons.person,
                        ),
                        CustomTextFormField(
                          controller: _emailController,
                          label: "Email",
                          iconData: Icons.email,
                          textInputType: TextInputType.emailAddress,
                        ),
                        CustomTextFormField(
                          controller: _phoneNumberController,
                          textInputType: TextInputType.number,
                          label: "Phone Number",
                          iconData: Icons.call,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: DropdownButtonFormField<String>(
                            value: _gender,
                            decoration: InputDecoration(
                              labelText: 'Gender',
                              hintText: 'Choose your gender',
                              prefixIcon: Icon(Icons.person_outline),
                              border: OutlineInputBorder(),
                            ),
                            items:
                                ['Male', 'female'].map((gender) {
                                  return DropdownMenuItem(
                                    value: gender,
                                    child: Text(gender),
                                  );
                                }).toList(),

                            onChanged: (val) => setState(() => _gender = val),
                            validator:
                                (val) =>
                                    val == null ? 'Gender is required' : null,
                          ),
                        ),
                        CustomTextFormField(
                          maxline: 3,
                          controller: _addressController,
                          label: "Address",
                          iconData: Icons.location_on,
                        ),
                        CustomTextFormField(
                          controller: _passwordController,
                          label: "Password",
                          obsecureText: true,
                          iconData: Icons.lock,
                        ),
                        CustomTextFormField(
                          controller: _confirmPasswordController,
                          obsecureText: true,
                          label: "Confirm Password",
                          iconData: Icons.lock_outline,
                        ),
                        SizedBox(height: 16),
                        GestureDetector(
                          onTap: () => registerUser(),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.blueAccent,
                            ),

                            height: 50,
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Aleady have an Account ?",
                style: TextStyle(color: Colors.black),
              ),

              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/loginscreen");
                },
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
