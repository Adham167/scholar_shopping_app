import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_shopping_app/cubits/login_cubit/login_cubit.dart';
import 'package:scholar_shopping_app/models/user_model.dart';
import 'package:scholar_shopping_app/widgets/custom_button.dart';
import 'package:scholar_shopping_app/widgets/custom_divider.dart';
import 'package:scholar_shopping_app/widgets/custom_text_form_field.dart';
import 'package:scholar_shopping_app/widgets/show_message.dart';
import 'package:scholar_shopping_app/widgets/welcome_back_section.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;

  final _emailcontroller = TextEditingController();

  final _passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          Navigator.pushReplacementNamed(
            context,
            "/homescreen",
          );
          isLoading = false;
        } else if (state is LoginFailure) {
          ShowMessage(context, state.errMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: ListView(
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 100),
                      WelcomeBackSection(),
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
                                  onTap: () {
                                    if (_formkey.currentState!.validate()) {
                                      BlocProvider.of<LoginCubit>(
                                        context,
                                      ).loginUser(
                                        email: _emailcontroller.text.trim(),
                                        password:
                                            _passwordcontroller.text.trim(),
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
                                    SnackBar(
                                      content: Text("Comming soon ........"),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                              ),
                              SizedBox(height: 32),
                              CustomDivider(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomButton(
                                  rout: "/homescreen",
                                  name: "Create an Account",
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
          ),
        );
      },
    );
  }
}
