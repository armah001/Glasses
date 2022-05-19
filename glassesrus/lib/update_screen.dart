import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glassesrus/profile.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  List users = [];
  var data = '';

  final double coverHeight = 280;
  final double profileHeight = 144;

  late var name = '';
  late var email = '';
  late var phone = '';

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      left: true,
      top: true,
      right: true,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Color(0xff99879D),
          ),
          backgroundColor: Colors.white,
          title: const Text(
            "Back",
            style: TextStyle(color: Color(0xff99879D)),
          ),
          elevation: 0,
        ),
        body: FutureBuilder(
            future: fetch(),
            builder: (context, snapshot) {
              return Padding(
                padding: EdgeInsets.all(15),
                child: Column(children: <Widget>[
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final String? name = _nameController.text;
                      final String? email = _emailController.text;
                      final String? phone = _phoneController.text;

                      final firebaseUser = FirebaseAuth.instance.currentUser;
                      final String? uid = firebaseUser?.uid.toString();

                      try {
                        DocumentReference post = await FirebaseFirestore
                            .instance
                            .collection('users')
                            .doc(uid)
                            .collection('info')
                            .get()
                            .then((QuerySnapshot snapshot) {
                          return snapshot.docs[0].reference;
                        });

                        WriteBatch batch = FirebaseFirestore.instance.batch();
                        batch.update(post, {
                          'fullName': _nameController.text,
                          'email': _emailController.text,
                          'phone': _phoneController.text,
                        });
                        batch.commit();
                      } catch (e) {
                        print(e);
                      }
                      Navigator.pop(context);
                    },
                    child: const Text('Update'),
                  ),
                ]),
              );
            }),
      ),
    );
  }

  Future<void> fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    final String? uid = firebaseUser?.uid.toString();

    if (firebaseUser != null) {
      var document = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: uid)
          .get();

      users = document.docs.map((doc) => doc.data()).toList();

      name = users[0]['fullName'];
      email = users[0]['email'];
      phone = users[0]['phone'];

      _nameController.text = name;
      _emailController.text = email;
      _phoneController.text = phone;
    }
  }
}
