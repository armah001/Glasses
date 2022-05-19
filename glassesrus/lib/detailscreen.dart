import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:glassesrus/cartscreen.dart';
import 'package:glassesrus/checkout.dart';
import 'package:glassesrus/homepage.dart';
import 'package:glassesrus/mybutton.dart';
import 'package:glassesrus/notification_button.dart';
import 'package:flutter/material.dart';
import 'package:glassesrus/product_provider.dart';

//import 'package:get/get.dart';
class DetailScreen extends StatefulWidget {
  late final String image;
  late final String name;
  late final double price;
  DetailScreen({required this.image, required this.name, required this.price});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  //const DetailScreen({Key? key}) : super(key: key);
  int count = 1;
  Widget _buildSizeProduct({String? name}) {
    return Container(
      height: 60,
      width: 60,
      color: Colors.grey,
      child: Center(
        child: Text(
          name!,
          style: TextStyle(
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  final TextStyle myStyle = TextStyle(
    fontSize: 18,
  );

  Widget _buildImage() {
    return Center(
      child: Container(
        width: 350,
        child: Card(
          child: Container(
            padding: EdgeInsets.all(13),
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                //color: Colors.orangeAccent,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(widget
                      .image /*"assets /images/redowan-dhrubo-9-U5LhHn1Zs-unsplash.jpeg"*/),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameToDescription() {
    return Container(
      height: 100,
      //color: Colors.grey,
      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.name,
                /*"Simple Glasses"*/
                style: myStyle,
              ),
              Text(
                "\$ ${widget.price.toString()}" /*"30.0"*/,
                style: TextStyle(color: Color(0xff9b96d6), fontSize: 18),
              ),
              Text(
                "Description",
                style: myStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDiscription() {
    return Container(
      height: 110,
      color: Colors.white70,
      child: Wrap(
        children: <Widget>[
          Text(
            "Premium product delivered right to you from Ghana and beyond."
            "Brought right to your door.",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSizePart() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              "Size",
              style: myStyle,
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        /*Row(
          children: [
            Container(
              width: 220,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _buildSizeProduct(name: "S"),
                  _buildSizeProduct(name: "M"),
                  _buildSizeProduct(name: "L"),
                ],
              ),
            ),
          ],
        ),*/
      ],
    );
  }

  Widget _buildQuantity() {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Text(
              "Quantity",
              style: myStyle,
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Container(
              height: 30,
              width: 130,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    count.toString(),
                    style: myStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildButtonPart() {
    return Container(
      height: 45,
      width: double.infinity,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.grey,
        child: Text(
          "Add to Cart",
          style: myStyle,
        ),
        onPressed: () {
          addToCart();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) => CartScreen(
                  /* name: widget.name,
                image: widget.image,
                price: widget.price,*/
                  ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Details",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        actions: <Widget>[
          /* IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_none,
              color: Colors.black,
            ),
          )*/
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildImage(),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildNameToDescription(),
                  _buildDiscription(),
                  _buildSizePart(),
                  SizedBox(
                    height: 15,
                  ),
                  _buildQuantity(),
                  SizedBox(
                    height: 15,
                  ),
                  _buildButtonPart(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addToCart() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    var users = FirebaseFirestore.instance
        .collection('carts')
        .doc(uid)
        .collection('items')
        .add({
      'name': widget.name,
      'image': widget.image,
      'price': widget.price
    });
  }
}
