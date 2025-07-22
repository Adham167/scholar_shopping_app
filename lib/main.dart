import 'package:flutter/material.dart';
import 'package:scholar_shopping_app/screens/home_screen.dart';
import 'package:scholar_shopping_app/screens/login_screen.dart';
import 'package:scholar_shopping_app/screens/product_details_screen.dart';
import 'package:scholar_shopping_app/screens/register_screen.dart';
import 'package:scholar_shopping_app/screens/splach_screen.dart';

void main() async {
  

  runApp(ScholarShoppingApp());
}

class ScholarShoppingApp extends StatelessWidget {
  const ScholarShoppingApp({super.key, this.initialRoute});
final initialRoute;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => SplachScreen(),
        "/homescreen": (context) => HomeScreen(),
        "/loginscreen": (context) => LoginScreen(),
        "/registerscreen": (context) => RegisterScreen(),
      },
      initialRoute: "/",
    );
  }
}
