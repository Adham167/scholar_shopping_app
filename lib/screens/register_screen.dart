import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scholar_shopping_app/widgets/custom_text_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  File? _imageFile;

  final _formkey = GlobalKey<FormState>();
  final _fulltNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _gender;

  Future<void> _registerUser() async {
    if (_formkey.currentState!.validate() && _gender != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("fulltname", _fulltNameController.text.trim());
      await prefs.setString("phonenumber", _phoneNumberController.text.trim());
      await prefs.setString("address", _addressController.text.trim());
      await prefs.setString("email", _emailController.text.trim());
      await prefs.setString("password", _passwordController.text.trim());
      await prefs.setString(
        "confirm password",
        _confirmPasswordController.text.trim(),
      );
      await prefs.setString("gender", _gender!);
      if (_imageFile != null) {
        await prefs.setString("profileImagePath", _imageFile!.path);
      }

      if (_passwordController.text.trim() !=
          _confirmPasswordController.text.trim()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Confirm Password not equal Password")),
        );
      } else {
        Navigator.pushReplacementNamed(context, "/loginscreen");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Pless fill all fields before submit")),
      );
    }
  }

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
                          controller: _fulltNameController,
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
                          onTap: () => _registerUser(),
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
