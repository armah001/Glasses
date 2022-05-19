import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glassesrus/checkout.dart';
import 'package:glassesrus/home.dart';
import 'homepage.dart';
//import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  /* final double price;
  final String name;
  final String image;
  CartScreen({required this.name, required this.image, required this.price});
*/
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int count = 1;
  var _cart = FirebaseFirestore.instance;
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();
  late List cartData = [];
  late QuerySnapshot querySnapshot;

  final TextStyle myStyle = TextStyle(
    fontSize: 18,
  );

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 45,
        width: 100,
        //margin: EdgeInsets.symmetric(horizontal: 10),
        // padding: EdgeInsets.only(bottom: 10),
        child: RaisedButton(
          color: Colors.orangeAccent,
          child: Text(
            "Check Out",
            style: myStyle,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => CheckOut(
                    /*image: widget.image,
                  price: widget.price,
                  name: widget.name,*/
                    ),
              ),
            );
          },
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Cart",
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
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => HomePage(),
              ),
            );
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
      body: ListView(
        children: <Widget>[
          (cartData.isEmpty)
              ? const Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  child: Text("No items in cart"),
                )
              : const Text(""),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: cartData.length,
              itemBuilder: (context, index) {
                return _buildSingleCartProduct(
                  index,
                  cartData[index]["image"],
                  cartData[index]["name"],
                  cartData[index]["price"],
                );
              }),
          /* _buildSingleCartProduct(),*/
        ],
      ),
    );
  }

  Future<void> getData() async {
    querySnapshot =
        await _cart.collection('carts').doc(uid).collection('items').get();

    setState(() {
      cartData = querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Widget _buildSingleCartProduct(
      int index, String image, String name, double price) {
    return Container(
      height: 150,
      width: double.infinity,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 130,
                  width: 150,
                  child: Image.network(
                    image,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  height: 140,
                  width: 200,
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(name),
                        Text("Evey Day Wear"),
                        Text(
                          price.toString(),
                          style: TextStyle(
                              color: Color(0xff9b96d6),
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 35,
                              width: 120,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, left: 50),
                                child: Text(
                                  count.toString(),
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  showDeleteDialog(context, index);
                                },
                                icon: Icon(Icons.delete))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showDeleteDialog(context, int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Item'),
          content: const SingleChildScrollView(
            child: Text('Are you sure you want to delete this item?'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Yes',
                style: TextStyle(color: Color(0xFFFFFFFF)),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black)),
              onPressed: () async {
                querySnapshot.docs[index].reference.delete();
                getData();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'No',
                style: TextStyle(color: Color(0xFFFFFFFF)),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
