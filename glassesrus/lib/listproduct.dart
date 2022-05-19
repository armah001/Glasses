import 'package:glassesrus/product.dart';
import 'package:glassesrus/category_provider.dart';
import 'package:glassesrus/product_provider.dart';
import 'package:glassesrus/detailscreen.dart';
import 'package:glassesrus/homepage.dart';
import 'package:glassesrus/search_product.dart';
import 'package:glassesrus/notification_button.dart';
import 'package:glassesrus/singleproduct.dart';
import 'package:flutter/material.dart';

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

class ListProduct extends StatelessWidget {
  late final String name;
  ListProduct({required this.name});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            }),
        actions: <Widget>[
          /* IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),*/
          /*  IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications_none, color: Colors.black)),*/
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            Column(
              children: <Widget>[
                Container(
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 700,
                  child: GridView.count(
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.71,
                    crossAxisCount: 2,
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      SingleProduct(
                          name: glassesData!.name,
                          price: glassesData!.price,
                          image: glassesData!.image),
                      SingleProduct(
                          name: glassesData3!.name,
                          price: glassesData3!.price,
                          image: glassesData3!.image),
                      SingleProduct(
                          name: glassesData2!.name,
                          price: glassesData2!.price,
                          image: glassesData2!.image),
                      SingleProduct(
                          name: glassesData4!.name,
                          price: glassesData4!.price,
                          image: glassesData4!.image),
                      SingleProduct(
                          name: productsData3!.name,
                          price: productsData3!.price,
                          image: productsData3!.image),
                      SingleProduct(
                          name: productsData4!.name,
                          price: productsData4!.price,
                          image: productsData4!.image),
                      /*SingleProduct(
                          name: glassesData6!.name,
                          price: glassesData6!.price,
                          image: glassesData6!.image),*/
                      /*SingleProduct(
                          name: glassesData7!.name,
                          price: glassesData7!.price,
                          image: glassesData7!.image),*/
                      /*SingleProduct(
                          name: glassesData8!.name,
                          price: glassesData8!.price,
                          image: glassesData8!.image),*/
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
}

/*
class ListProduct extends StatelessWidget {
  final String name;
  bool isCategory = true;
  final List<Product> snapShot;
  ListProduct({
    this.name,
    this.isCategory,
    this.snapShot,
  });

  Widget _buildTopName() {
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildMyGridView(context) {
    final Orientation orientation = MediaQuery.of(context).orientation;

    return Container(
      height: 700,
      child: GridView.count(
        crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
        childAspectRatio: orientation == Orientation.portrait ? 0.8 : 0.9,
        scrollDirection: Axis.vertical,
        children: snapShot
            .map(
              (e) => GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (ctx) => DetailScreen(
                            image: e.image,
                            name: e.name,
                            price: e.price,
                          )));
                },
                child: SingleProduct(
                  price: e.price,
                  image: e.image,
                  name: e.name,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  CategoryProvider categoryProvider;
  ProductProvider productProvider;
  Widget _buildSearchBar(context) {
    return isCategory == true
        ? IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              categoryProvider.getSearchList(list: snapShot);
              showSearch(context: context, delegate: SearchCategory());
            },
          )
        : IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            onPressed: () {
              productProvider.getSearchList(list: snapShot);
              showSearch(context: context, delegate: SearchProduct());
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    categoryProvider = Provider.of<CategoryProvider>(context);
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
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
            }),
        actions: <Widget>[
          _buildSearchBar(context),
          NotificationButton(),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: <Widget>[
            _buildTopName(),
            SizedBox(
              height: 10,
            ),
            _buildMyGridView(context),
          ],
        ),
      ),
    );
  }
}
*/
