import 'package:flutter/material.dart';
import 'package:glassesrus/checkout.dart';
import 'package:glassesrus/homepage.dart';

class Success_Order extends StatelessWidget {
  const Success_Order({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(height: 230),
          buildSuccessOrder(context),
        ],
      ),
    );
  }
}

Widget buildSuccessOrder(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      const Text(
        'Check Out Successful',
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
              context, MaterialPageRoute(builder: (context) => HomePage()));
        },
        child: RichText(
          text: const TextSpan(children: [
            TextSpan(
              text: 'Click to ',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: ' Continue Shopping',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            )
          ]),
        ),
      ),
    ],
  );
}
