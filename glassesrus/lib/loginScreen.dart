import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glassesrus/homepage.dart';
import 'package:glassesrus/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//change color scheme to suit figma designs

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    initializeAppFirebase();
  }

  initializeAppFirebase() async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Color(0xffFFFFFF),
                      Color(0xffFFFFFF),
                      Color(0xffFFFFFF),
                      Color(0xffFFFFFF),
                    ])),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets /icons/GlassesRUs.png',
                      ),
                      const Text(
                        'Log-In',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Email',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6,
                                      offset: Offset(0, 2))
                                ]),
                            height: 60,
                            child: TextField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14),
                                prefixIcon:
                                    Icon(Icons.email, color: Color(0xffffffff)),
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.white),
                                filled: true,
                                fillColor: Color(0xE3A850),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Password',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6,
                                      offset: Offset(0, 2))
                                ]),
                            height: 60,
                            child: TextField(
                              obscureText: true,
                              controller: _passwordController,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14),
                                prefixIcon:
                                    Icon(Icons.lock, color: Color(0xffffffff)),
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Colors.white),
                                filled: true,
                                fillColor: Color(0x00e3a850),
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 25),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async => {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email:
                                        _emailController.text.toString().trim(),
                                    password: _passwordController.text
                                        .toString()
                                        .trim()),
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()))
                          },
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(5),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(
                                15,
                              )),
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xffE3A850)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ))),
                          child: const Text(
                            'LOG IN',
                            style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: RichText(
                          text: const TextSpan(children: [
                            TextSpan(
                              text: 'Don\'t have an Account? ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))
                          ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
