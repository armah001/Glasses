import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:glassesrus/loginScreen.dart';
import 'package:glassesrus/sucess.dart';
import 'package:glassesrus/user.dart';

//change color scheme to suit figma design

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

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
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 25),
                      const Text(
                        'Sign-Up',
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
                            'Full Name',
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
                              controller: _nameController,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14),
                                prefixIcon: Icon(Icons.account_box,
                                    color: Color(0xffffffff)),
                                hintText: 'Full Name',
                                hintStyle: TextStyle(color: Colors.white),
                                filled: true,
                                fillColor: Color(0xff9A9A9A),
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
                                fillColor: Color(0xff9A9A9A),
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
                                fillColor: Color(0xff9A9A9A),
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
                            'Phone',
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
                              controller: _phoneController,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14),
                                prefixIcon: Icon(Icons.add_ic_call,
                                    color: Color(0xffffffff)),
                                hintText: 'Phone',
                                hintStyle: TextStyle(color: Colors.white),
                                filled: true,
                                fillColor: Color(0xff9A9A9A),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 25),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              await Firebase.initializeApp();
                              UserCredential user = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                              User updateUser =
                                  FirebaseAuth.instance.currentUser!;
                              updateUser.updateProfile(
                                displayName: _nameController.text,
                              );
                              userSetup(_emailController.text,
                                  _nameController.text, _phoneController.text);

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Success_Screen()));
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                print('The password provided is too weak.');
                              } else if (e.code == 'email-already-in-use') {
                                print(
                                    'The account already exists for that email.');
                              }
                            } catch (e) {
                              print(e.toString());
                            }
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
                            'SIGN UP',
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
                                  builder: (context) => LoginScreen()));
                        },
                        child: RichText(
                          text: const TextSpan(children: [
                            TextSpan(
                              text: 'Already have an Account? ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            TextSpan(
                                text: 'Log In',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))
                          ]),
                        ),
                      ),
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
