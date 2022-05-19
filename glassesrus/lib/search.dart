import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'detailscreen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _feed = FirebaseFirestore.instance;
  late List Data = [];
  late QuerySnapshot querySnapshot;
  String searchString = "";

  @override
  void initState() {
    super.initState();
    getMenuData();
  }

  Future<void> getMenuData() async {
    querySnapshot = await _feed
        .collection('products')
        .doc("pdz2CzauAIb0WU5FQ5SX")
        .collection("featureproduct")
        .get();

    setState(() {
      Data = querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xff99879D),
        ),
        backgroundColor: Colors.white,
        // title: const Text(
        //   "Back",
        //   style: TextStyle(color: Colors.black),
        // ), TextButton()
        title: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Back", style: TextStyle(color: Colors.black))),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchString = value.toLowerCase();
                        });
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        hintText: 'Search',
                        suffixIcon: Icon(Icons.search, size: 37),
                      )),
                ),
                (Data.isEmpty)
                    ? const Padding(
                        padding: EdgeInsets.only(top: 40.0),
                        child: Text("No Glasses Available"),
                      )
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: Data.length,
                        itemBuilder: (context, index) {
                          return Data[index]['name']
                                  .toLowerCase()
                                  .contains(searchString)
                              ? GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (ctx) => DetailScreen(
                                        image: Data[index]['image'],
                                        name: Data[index]['name'],
                                        price: double.parse(
                                            Data[index]['price'].toString()),
                                      ),
                                    ));
                                  },
                                  child: ListTile(
                                    leading: Container(
                                      child: Image.network(
                                        Data[index]['image'],
                                        width: 56,
                                        height: 56,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    title: Text(Data[index]['name']),
                                    subtitle:
                                        Text(Data[index]['price'].toString()),
                                  ),
                                )
                              : Text("");
                        }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
