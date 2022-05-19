import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> userSetup(String email, String fullName, String phone) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  CollectionReference users = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection("info");

  users.add({
    'uid': uid,
    'email': email,
    'fullName': fullName,
    'phone': phone,
  });
  return;
}
