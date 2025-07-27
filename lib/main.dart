import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_shopping_app/cubits/category_cubit/category_cubit.dart';
import 'package:scholar_shopping_app/cubits/login_cubit/login_cubit.dart';
import 'package:scholar_shopping_app/cubits/product_cubit/product_cubit.dart';
import 'package:scholar_shopping_app/cubits/register_cubit/regiser_cubit.dart';
import 'package:scholar_shopping_app/firebase_options.dart';
import 'package:scholar_shopping_app/screens/dashboard_screens.dart';
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
    return MultiBlocProvider(
      providers: [
            BlocProvider(create: (context) => LoginCubit()),
            BlocProvider(create: (context) => RegiserCubit()),
            BlocProvider(create: (context) => CategoryCubit()),
            BlocProvider(create: (context) => ProductCubit()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) => SplachScreen(),
          "/homescreen": (context) => HomeScreen(),
          "/loginscreen": (context) => LoginScreen(),
          "/registerscreen": (context) => RegisterScreen(),
          "/shoppingcart": (context) => ShoppingCart(),
          "/orderscreen": (context) => OrderedScreen(),
          "/dashboard": (context) => DashboardScreens(),
        },
        initialRoute: "/",
      ),
    );
  }
}
