/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glassesrus/categoryicon.dart';
import 'package:flutter/material.dart';
import 'package:glassesrus/product.dart';

class CategoryProvider with ChangeNotifier {
  List<Product> glasses = [];
  late Product glassesData;

  List<CategoryIcon> glasesIcon = [];
  late CategoryIcon glassesiconData;

  Future<void> getGlassesIconData() async {
    List<CategoryIcon> newList = [];
    QuerySnapshot dressSnapShot = await FirebaseFirestore.instance
        .collection("categoryicon")
        .doc("SiNJYcU8RRVrXaLUL9v3")
        .collection("dress")
        .get();
    dressSnapShot.docs.forEach(
      (element) {
        glassesiconData = CategoryIcon(image: element.data()["image"]);
        newList.add(glassesiconData);
      },
    );
    glasesIcon = newList;
    notifyListeners();
  }

  List<CategoryIcon> get getGlassesIcon {
    return glasesIcon;
  }

  Future<void> getGlassesData() async {
    List<Product> newList = [];
    QuerySnapshot shirtSnapShot = await FirebaseFirestore.instance
        .collection("category")
        .doc("hKyfiWV7zSLen6HYJgVf")
        .collection("dress")
        .get();
    shirtSnapShot.docs.forEach(
      (element) {
        glassesData = Product(
            image: element.data()["image"],
            name: element.data()["name"],
            price: element.data()["price"]);
        newList.add(glassesData);
      },
    );
    glasses = newList;
    notifyListeners();
  }

  List<Product> get getGlassesList {
    return glasses;
  }

  late List<Product> searchList;
  void getSearchList({required List<Product> list}) {
    searchList = list;
  }

  List<Product> searchCategoryList(String query) {
    List<Product> searchGlasses = searchList.where((element) {
      return element.name.toUpperCase().contains(query) ||
          element.name.toLowerCase().contains(query);
    }).toList();
    return searchGlasses;
  }
}
*/
