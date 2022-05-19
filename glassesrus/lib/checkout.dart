import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:glassesrus/cartmodel.dart';
import 'package:glassesrus/cartscreen.dart';
import 'package:glassesrus/orderRecieved.dart';
import 'package:glassesrus/product_provider.dart';
import 'package:glassesrus/homepage.dart';
import 'package:glassesrus/checkout_singleproduct.dart';
import 'package:glassesrus/mybutton.dart';
import 'package:glassesrus/notification_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({Key? key}) : super(key: key);
  /*final double price;
  final String name;
  final String image;
  CheckOut({required this.name, required this.image, required this.price});
*/
  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  var _cart = FirebaseFirestore.instance;
  String uid = FirebaseAuth.instance.currentUser!.uid.toString();
  late List cartData = [];
  late QuerySnapshot querySnapshot;
  double total = 0;

  final TextStyle myStyle = TextStyle(
    fontSize: 18,
  );
  @override
  void initState() {
    super.initState();
    getData();
    updateTotal();
  }

  Future<void> getData() async {
    querySnapshot =
        await _cart.collection('carts').doc(uid).collection('items').get();

    setState(() {
      cartData = querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    updateTotal();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Check Out",
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
                builder: (ctx) => CartScreen(
                    /* name: widget.name,
                    image: widget.image,
                    price: widget.price*/
                    ),
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
      bottomNavigationBar: Container(
        height: 70,
        width: 100,
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.only(bottom: 15),
        child: RaisedButton(
          color: Colors.orangeAccent,
          child: Text(
            "Check Out",
            style: myStyle,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => Success_Order(),
              ),
            );
          },
        ),
      ),
      body: Container(
        //scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 100,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Check Out",
                        style: TextStyle(fontSize: 28),
                      ),
                    ],
                  ),
                ),
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
                        cartData[index]["image"],
                        cartData[index]["name"],
                        cartData[index]["price"],
                      );
                    }),
                Container(
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildBottomDetail(
                        startName: "Total",
                        endName: total.toString(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void updateTotal() {
    double x = 0;
    for (var i = 0; i < cartData.length; i++) {
      x += cartData[i]['price'];
      print(cartData[i]['price']);
    }

    setState(() {
      total = x;
    });
  }

  Widget _buildSingleCartProduct(String image, String name, double price) {
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
                  child: Image.network(image),
                ),
                Container(
                  height: 140,
                  width: 200,
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          name,
                          style: myStyle,
                        ),
                        Text(
                          "Evey Day Wear",
                          style: myStyle,
                        ),
                        Text(
                          price.toString(),
                          style: TextStyle(
                              color: Color(0xff9b96d6),
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Color(0xfff2f2f2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text("Quantity"),
                              Text("1"),
                            ],
                          ),
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

  Widget _buildBottomDetail(
      {required String startName, required String endName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          startName,
          style: myStyle,
        ),
        Text(
          endName,
          style: myStyle,
        ),
      ],
    );
  }
}
