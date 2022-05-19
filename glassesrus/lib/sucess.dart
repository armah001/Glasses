import 'package:flutter/material.dart';
import 'package:glassesrus/loginScreen.dart';

class Success_Screen extends StatelessWidget {
  const Success_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(height: 230),
          buildSuccess(context),
        ],
      ),
    );
  }
}

Widget buildSuccess(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      const Text(
        'Success',
        style: TextStyle(
          fontSize: 25,
          color: Color(0xff120E21),
        ),
      ),
      const SizedBox(height: 50),
      Image.asset(
        'assets /icons/successbg.png',
        width: 200,
        fit: BoxFit.fitWidth,
      ),
      const SizedBox(height: 50),
      GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        },
        child: RichText(
          text: const TextSpan(children: [
            TextSpan(
              text: 'Log In',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
                text: 'to access your account.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ))
          ]),
        ),
      ),
    ],
  );
}
