import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:glassesrus/categoryicon.dart';
import 'package:glassesrus/product.dart';
import 'package:glassesrus/product_provider.dart';
import 'package:glassesrus/profile.dart';
import 'package:glassesrus/usermodel.dart';
import 'package:glassesrus/about.dart';
import 'package:glassesrus/checkout.dart';
import 'package:glassesrus/loginScreen.dart';
//import 'package:glassesrus/profilescreen.dart';
import 'package:glassesrus/product_provider.dart';
import 'package:glassesrus/category_provider.dart';
import 'package:glassesrus/detailscreen.dart';
import 'package:glassesrus/listproduct.dart';
import 'package:glassesrus/singleproduct.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:glassesrus/search.dart';

import 'package:glassesrus/product.dart';
import 'package:glassesrus/notification_button.dart';

import 'cartscreen.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

Product? glassesData;
Product? glassesData1;
Product? glassesData2;
Product? glassesData3;
Product? glassesData4;
Product? glassesData5;
Product? glassesData6;
Product? glassesData7;
Product? glassesData8;
Product? glassesData9;
Product? glassesData10;
//product data
Product? productsData1;
Product? productsData2;
Product? productsData3;
Product? productsData4;
Product? productsData5;
Product? productsData6;
Product? productsData7;
Product? productsData8;
Product? productsData9;
var mySnapshot;

/*@override
void initState() {
  Product price.toString(); // tried to convert into string
  super.initState();
}*/

class _HomePageState extends State<HomePage> {
  Widget _buildFeaturedProduct({String? name, double? price, String? image}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      //for box
      child: Container(
        height: 230,
        width: 170,
        // color: Colors.orangeAccent,
        child: Column(
          children: <Widget>[
            //for image
            Container(
              height: 190,
              width: 160,
              //color: Colors.grey,
              decoration: BoxDecoration(
                //color: Colors.grey,
                image: DecorationImage(
                  image: AssetImage("assets /images/$image"),
                ),
              ),
            ),
            Text(
              "\$ $price",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Color(0xff9b96d6)),
            ),
            Text(
              name!,
              style: TextStyle(
                fontSize: 17,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryProduct({String? image}) {
    return CircleAvatar(
      maxRadius: 25,
      backgroundColor: Color(0xff33dcfd),
      child: Container(
        //height of icon
        height: 25,
        child: Image(
          color: Colors.white,
          image: AssetImage("assets /images/$image"),
          // image: NetworkImage(image!),
        ),
      ),
    );
  }

  Widget _buildCategoryArchives({String? name, double? price, String? image}) {
    return Column();
  }

  bool homeColor = true;

  bool cartColor = false;

  bool aboutColor = false;
  bool profileColor = false;

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  Widget _buildFeature() {
    return Column(
      children: <Widget>[],
    );
  }

  final CollectionReference _products =
      FirebaseFirestore.instance.collection("products");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: _buildMyDrawer(),
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey[100],
        leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              _key.currentState?.openDrawer();
            }),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => SearchPage(),
                  ),
                );
              },
              icon: Icon(Icons.search, color: Colors.black)),
        ],
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("products")
              .doc("pdz2CzauAIb0WU5FQ5SX")
              .collection("featureproduct")
              .get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            mySnapshot = snapshot;

            glassesData = Product(
                image: snapshot.data!.docs[0]["image"],
                name: snapshot.data!.docs[0]["name"],
                price: snapshot.data!.docs[0]["price"].toDouble());
            print(glassesData);

            glassesData1 = Product(
                image: snapshot.data!.docs[1]["image"],
                name: snapshot.data!.docs[1]["name"],
                price: snapshot.data!.docs[1]["price"].toDouble());
            glassesData2 = Product(
                image: snapshot.data!.docs[3]["image"],
                name: snapshot.data!.docs[3]["name"],
                price: snapshot.data!.docs[3]["price"].toDouble());
            glassesData3 = Product(
                image: snapshot.data!.docs[4]["image"],
                name: snapshot.data!.docs[4]["name"],
                price: snapshot.data!.docs[4]["price"].toDouble());
            glassesData4 = Product(
                image: snapshot.data!.docs[5]["image"],
                name: snapshot.data!.docs[5]["name"],
                price: snapshot.data!.docs[5]["price"].toDouble());
            glassesData5 = Product(
                image: snapshot.data!.docs[6]["image"],
                name: snapshot.data!.docs[6]["name"],
                price: snapshot.data!.docs[6]["price"].toDouble());
            glassesData6 = Product(
                image: snapshot.data!.docs[2]["image"],
                name: snapshot.data!.docs[2]["name"],
                price: snapshot.data!.docs[2]["price"].toDouble());
            glassesData7 = Product(
                image: snapshot.data!.docs[7]["image"],
                name: snapshot.data!.docs[7]["name"],
                price: snapshot.data!.docs[7]["price"].toDouble());
            glassesData8 = Product(
                image: snapshot.data!.docs[8]["image"],
                name: snapshot.data!.docs[8]["name"],
                price: snapshot.data!.docs[8]["price"].toDouble());
            glassesData9 = Product(
                image: snapshot.data!.docs[9]["image"],
                name: snapshot.data!.docs[9]["name"],
                price: snapshot.data!.docs[9]["price"].toDouble());

            return FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("products")
                    .doc("pdz2CzauAIb0WU5FQ5SX")
                    .collection("newproducts")
                    .get(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapShot) {
                  if (snapShot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  productsData1 = Product(
                      image: snapShot.data!.docs[0]["image"],
                      name: snapShot.data!.docs[0]["name"],
                      price: snapShot.data!.docs[0]["price"].toDouble());
                  productsData2 = Product(
                      image: snapshot.data!.docs[1]["image"],
                      name: snapshot.data!.docs[1]["name"],
                      price: snapshot.data!.docs[1]["price"].toDouble());
                  productsData3 = Product(
                      image: snapshot.data!.docs[2]["image"],
                      name: snapshot.data!.docs[2]["name"],
                      price: snapshot.data!.docs[2]["price"].toDouble());
                  productsData4 = Product(
                      image: snapshot.data!.docs[3]["image"],
                      name: snapshot.data!.docs[3]["name"],
                      price: snapshot.data!.docs[3]["price"].toDouble());
                  productsData5 = Product(
                      image: snapshot.data!.docs[4]["image"],
                      name: snapshot.data!.docs[4]["name"],
                      price: snapshot.data!.docs[4]["price"].toDouble());
                  productsData6 = Product(
                      image: snapshot.data!.docs[5]["image"],
                      name: snapshot.data!.docs[5]["name"],
                      price: snapshot.data!.docs[5]["price"].toDouble());
                  productsData7 = Product(
                      image: snapshot.data!.docs[6]["image"],
                      name: snapshot.data!.docs[6]["name"],
                      price: snapshot.data!.docs[6]["price"].toDouble());
                  productsData8 = Product(
                      image: snapshot.data!.docs[7]["image"],
                      name: snapshot.data!.docs[7]["name"],
                      price: snapshot.data!.docs[7]["price"].toDouble());
                  return Container(
                    //color: Colors.grey,
                    height: double.infinity,
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20),

                    child: ListView(
                      children: [
                        Container(
                          height: 130,
                          // color: Colors.orangeAccent,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              /* Container(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.search),
                                      hintText: "Search something",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                ),
                              ),*/
                              /*Container(
                              height: 200,
                              child: Carousel(
                                dotColor: Colors.white,
                                autoplay: true,
                                dotBgColor: Colors.white,
                                dotIncreaseSize: 10,
                                dotIncreasedColor: Colors.blueAccent,
                                dotSize: 20,
                                images: [
                                  AssetImage(
                                      "assets /images/redowan-dhrubo-9-U5LhHn1Zs-unsplash.jpeg"),
                                  AssetImage(
                                      "assets /images/redowan-dhrubo-9-U5LhHn1Zs-unsplash.jpeg")
                                ],
                              ),
                            ),*/
                              Container(
                                height: 50,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Featured",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder: (ctx) => ListProduct(
                                                  name: "Featured",
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            "See All",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (ctx) => DetailScreen(
                                              image: glassesData!.image,
                                              name: glassesData!.name,
                                              price: glassesData!.price),
                                        ),
                                      );
                                    },
                                    child: SingleProduct(
                                        name: glassesData!.name,
                                        price: glassesData!.price,
                                        image: glassesData!.image),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (ctx) => DetailScreen(
                                              image: glassesData1!.image,
                                              name: glassesData1!.name,
                                              price: glassesData1!.price),
                                        ),
                                      );
                                    },
                                    child: SingleProduct(
                                        name: glassesData1!.name,
                                        price: glassesData1!.price,
                                        image: glassesData1!.image),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (ctx) => DetailScreen(
                                              image: glassesData2!.image,
                                              name: glassesData2!.name,
                                              price: glassesData2!.price),
                                        ),
                                      );
                                    },
                                    child: SingleProduct(
                                        name: glassesData2!.name,
                                        price: glassesData2!.price,
                                        image: glassesData2!.image),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (ctx) => DetailScreen(
                                              image: glassesData3!.image,
                                              name: glassesData3!.name,
                                              price: glassesData3!.price),
                                        ),
                                      );
                                    },
                                    child: SingleProduct(
                                        name: glassesData3!.name,
                                        price: glassesData3!.price,
                                        image: glassesData3!.image),
                                  ),
                                ],
                              ),
                            ),

                            //rest of products
                            Container(
                              height: 50,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Products",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (ctx) => ListProduct(
                                                name: "Products",
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          "See All",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (ctx) => DetailScreen(
                                              image: productsData1!.image,
                                              name: productsData1!.name,
                                              price: productsData1!.price),
                                        ),
                                      );
                                    },
                                    child: SingleProduct(
                                        name: productsData1!.name,
                                        price: productsData1!.price,
                                        image: productsData1!.image),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (ctx) => DetailScreen(
                                              image: productsData3!.image,
                                              name: productsData3!.name,
                                              price: productsData3!.price),
                                        ),
                                      );
                                    },
                                    child: SingleProduct(
                                        name: productsData3!.name,
                                        price: productsData3!.price,
                                        image: productsData3!.image),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                });
          }),
    );
  }

  Widget _buildMyDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              "",
              style: TextStyle(color: Colors.black),
            ),
            currentAccountPicture: CircleAvatar(
              maxRadius: 25,
              backgroundImage: AssetImage("assets /images/avatar.png"),
            ),
            decoration: BoxDecoration(color: Colors.white),
            accountEmail: Text("", style: TextStyle(color: Colors.black)),
          ),
          ListTile(
            selected: homeColor,
            onTap: () {
              setState(() {
                homeColor = true;
                aboutColor = false;
                cartColor = false;
                profileColor = false;
              });
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
            selected: cartColor,
            onTap: () {
              setState(() {
                cartColor = true;
                aboutColor = false;
                homeColor = false;
                profileColor = false;
              });
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (ctx) => CartScreen(),
              ));
            },
            leading: Icon(Icons.shopping_cart),
            title: Text("Cart"),
          ),
          ListTile(
            selected: profileColor,
            onTap: () {
              setState(() {
                aboutColor = false;
                homeColor = false;
                profileColor = true;
                cartColor = false;
              });
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
            },
            leading: Icon(Icons.info),
            title: Text("Profile"),
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
            leading: Icon(Icons.logout),
            title: Text("LogOut"),
          ),
        ],
      ),
    );
  }
}
