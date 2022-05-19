import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
//import 'package:workwaves/views/nav/profile.dart';
//import 'package:workwaves/views/nav/search.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GlassesRUs',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  String _appBar = "Home";

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black);
  List<Widget> _widgetOptions = <Widget>[];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          {
            _appBar = 'Home';
          }
          break;
        case 1:
          {
            _appBar = 'Search';
          }
          break;
        case 2:
          {
            _appBar = 'Profile';
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBar),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
            backgroundColor: Colors.blueGrey,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: 'Search',
            backgroundColor: Colors.blueGrey,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
            ),
            label: 'Profile',
            backgroundColor: Colors.blueGrey,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
