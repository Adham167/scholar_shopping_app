import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_shopping_app/cubits/register_cubit/regiser_cubit.dart';
import 'package:scholar_shopping_app/widgets/custom_text_form_field.dart';
import 'package:scholar_shopping_app/widgets/custom_text_row.dart';
import 'package:scholar_shopping_app/widgets/show_message.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  String? email;
  String? password;
  String? fullname;
  String? address;
  String? phone;
  String? confirmPassword;
  GlobalKey<FormState> formKey = GlobalKey();
  String? _gender;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegiserCubit, RegiserState>(
      listener: (context, state) {
        if (state is RegiserLoading) {
          isLoading = true;
        } else if (state is RegiserSuccess) {
          FirebaseAuth.instance.currentUser!.sendEmailVerification();

          if (FirebaseAuth.instance.currentUser!.emailVerified) {
            Navigator.pushReplacementNamed(context, "/loginscreen");
            isLoading = false;
          } else {
            ShowMessage(context, "email not verified");
          }
        } else if (state is RegiserFailure) {
          ShowMessage(context, state.errMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
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
                              // backgroundImage:
                              //     _imageFile != null
                              //         ? FileImage(_imageFile!)
                              //         : null,
                              child: Icon(
                                Icons.person,
                                size: 60,
                                color: Colors.white,
                              ),
                            ),

                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: GestureDetector(
                                onTap: () {},
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
                          key: formKey,
                          child: Column(
                            children: [
                              CustomTextFormField(
                                onChange: (data) {
                                  fullname = data;
                                },
                                label: "Full Name",
                                iconData: Icons.person,
                              ),
                              CustomTextFormField(
                                onChange: (data) => email = data,
                                label: "Email",
                                iconData: Icons.email,
                                textInputType: TextInputType.emailAddress,
                              ),
                              CustomTextFormField(
                                onChange: (data) => phone = data,
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

                                  onChanged: (val) => _gender = val,
                                  validator:
                                      (val) =>
                                          val == null
                                              ? 'Gender is required'
                                              : null,
                                ),
                              ),
                              CustomTextFormField(
                                maxline: 3,
                                onChange: (data) => address = data,
                                label: "Address",
                                iconData: Icons.location_on,
                              ),
                              CustomTextFormField(
                                onChange: (data) => password = data,
                                label: "Password",
                                obsecureText: true,
                                iconData: Icons.lock,
                              ),
                              CustomTextFormField(
                                onChange: (data) => confirmPassword = data,
                                obsecureText: true,
                                label: "Confirm Password",
                                iconData: Icons.lock_outline,
                              ),
                              SizedBox(height: 16),
                              GestureDetector(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    if (password != confirmPassword) {
                                      ShowMessage(
                                        context,
                                        "Confirm Password not equal Password",
                                      );
                                      return;
                                    }
                                    BlocProvider.of<RegiserCubit>(
                                      context,
                                    ).registerUser(
                                      email: email!,
                                      password: password!,
                                      name: fullname!,
                                      phone: phone!,
                                      Confirmpassword: confirmPassword!,
                                      gender: _gender!,
                                      address: address!,
                                      isAdmin: false,
                                    );
                                  }
                                },
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
                CustomTextRow(),
              ],
            ),
          ),
        );
      },
    );
  }
}
