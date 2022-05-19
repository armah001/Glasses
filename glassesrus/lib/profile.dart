import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glassesrus/loginScreen.dart';
import 'package:glassesrus/update_screen.dart';

import 'homepage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List users = [];
  var data = '';

  final double coverHeight = 280;
  final double profileHeight = 144;

  String name = "User";
  String email = "Email";
  String phone = "Phone";

  @override
  void initState() {
    fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fetch();
    return Scaffold(
      body: ListView(
          //padding: EdgeInsets.zero,
          children: <Widget>[
            buildTop(),
            // buildMyDrawer(),
            buildContent(),
            SizedBox(height: 20),
            buildUpdate(),
            SizedBox(height: 90),
            buildSignOut(),
            buildhome(),
          ]),
    );
  }

  Widget buildMyDrawer() {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              name,
              style: TextStyle(color: Colors.black),
            ),
            currentAccountPicture: CircleAvatar(
              maxRadius: 25,
              backgroundImage: AssetImage("assets /images/avatar.png"),
            ),
            decoration: BoxDecoration(color: Colors.white),
            accountEmail: Text(email, style: TextStyle(color: Colors.black)),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop(
                MaterialPageRoute(
                  builder: (ctx) => HomePage(),
                ),
              );
            },
            leading: Icon(Icons.home),
            title: Text("Home"),
          ),
          ListTile(
            onTap: () {
              /*Navigator.of(context).pop(
                MaterialPageRoute(
                  builder: (ctx) => CheckOut(),
                ),
              );*/
            },
            leading: Icon(Icons.shopping_cart),
            title: Text("Cart"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => ProfilePage(),
                ),
              );
            },
            leading: Icon(Icons.info),
            title: Text("Profile"),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            leading: Icon(Icons.logout),
            title: Text("LogOut"),
          ),
        ],
      ),
    );
  }

  Widget buildTop() {
    final top = coverHeight - profileHeight / 2;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        buildCoverImage(),
        Positioned(
          top: top,
          child: buildProfileImage(),
        ),
      ],
    );
  }

  Widget buildContent() {
    return Container(
        child: FutureBuilder(
      future: fetch(),
      builder: (context, snapshot) {
        return Column(
          children: <Widget>[
            SizedBox(height: 60),
            Text(
              name,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 5),
            Align(
              child: Padding(
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  children: [
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      phone,
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff99879D),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    ));
  }

  Future<void> fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    final String? uid = firebaseUser?.uid.toString();

    if (firebaseUser != null) {
      var document = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('info')
          .get();

      setState(() {
        users = document.docs.map((doc) => doc.data()).toList();

        name = users[0]['fullName'];
        email = users[0]['email'];
        phone = users[0]['phone'];
      });
    }
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        child: Image.network(
          'https://images.unsplash.com/photo-1478760329108-5c3ed9d495a0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8YmFja2dyb3VuZHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60',
          height: coverHeight,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );

  Widget buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2.5,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: NetworkImage(
            "https://cdn-icons-png.flaticon.com/512/1077/1077012.png"),
      );

  Widget buildUpdate() => Container(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UpdateScreen()));
          },
          child: const Text('Update Profile'),
          style: ElevatedButton.styleFrom(
            primary: Colors.lightBlue,
          ),
        ),
      );

  Widget buildSignOut() => Align(
        alignment: Alignment.bottomRight,
        child: ElevatedButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: const Text('Sign Out'),
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
          ),
        ),
      );
  Widget buildhome() => Align(
        alignment: Alignment.bottomRight,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          child: const Text('Home'),
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
          ),
        ),
      );
}
