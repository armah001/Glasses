import 'package:flutter/material.dart';
import 'package:glassesrus/homepage.dart';
import 'package:glassesrus/listproduct.dart';
import 'package:glassesrus/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:glassesrus/home.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigateToLogin();
    WidgetsFlutterBinding.ensureInitialized();
    initializeAppFirebase();
  }

  initializeAppFirebase() async {
    await Firebase.initializeApp();
  }

  _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 253, 253),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets /icons/GlassesRUs.png",
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width,
          ),
          const CircularProgressIndicator(
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
            color: Color.fromARGB(255, 170, 170, 170),
          )
        ],
      )),
    );
  }
}
