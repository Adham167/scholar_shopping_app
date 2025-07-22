import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), ()async {
      final nextRoute = await _getNextrout();
      Navigator.pushReplacementNamed(context, nextRoute);
    });
  }

  Future<String> _getNextrout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool loggedIn = prefs.getBool("login") ?? false;
    
    final initialRoute = loggedIn ? "/homescreen" : "/loginscreen";
    return initialRoute;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: TweenAnimationBuilder(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.scale(scale: value, child: child),
          );
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                elevation: 8,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(Icons.shopping_bag, size: 60, color: Colors.blue),
                ),
              ),
              SizedBox(height: 32),
              Text(
                "Zaq Shopping App",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Opacity(
                opacity: 0.5,
                child: Text(
                  "Your One_Stop Shopping Destination",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),

              SizedBox(height: 32),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
