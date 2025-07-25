import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_shopping_app/cubits/login_cubit/login_cubit.dart';
import 'package:scholar_shopping_app/firebase_options.dart';
import 'package:scholar_shopping_app/screens/home_screen.dart';
import 'package:scholar_shopping_app/screens/login_screen.dart';
import 'package:scholar_shopping_app/screens/ordered_screen.dart';
import 'package:scholar_shopping_app/screens/register_screen.dart';
import 'package:scholar_shopping_app/screens/shopping_cart.dart';
import 'package:scholar_shopping_app/screens/splach_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ScholarShoppingApp());
}

class ScholarShoppingApp extends StatelessWidget {
  const ScholarShoppingApp({super.key, this.initialRoute});
  final initialRoute;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) => SplachScreen(),
          "/homescreen": (context) => HomeScreen(),
          "/loginscreen": (context) => LoginScreen(),
          "/registerscreen": (context) => RegisterScreen(),
          "/shoppingcart": (context) => ShoppingCart(),
          "/orderscreen": (context) => OrderedScreen(),
        },
        initialRoute: "/",
      ),
    );
  }
}
