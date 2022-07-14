import 'package:covid_pass/Resources/auth_methods.dart';
import 'package:covid_pass/Screens/login.dart';
import 'package:covid_pass/Screens/Home/components/statview.dart';
import 'package:flutter/material.dart';
import 'components/homeview.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BottomNavigationBarItem> barItem = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: "My Stats",
    ),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scanned Results"),
        centerTitle: false,
        actions: [
          IconButton(
            tooltip: "logout",
            onPressed: () {
              AuthMethods().logoutUser();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                  (route) => false);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      // ignore: prefer_const_constructors
      body: _currentIndex == 0 ? HomeView(): MyStat(),
      bottomNavigationBar: BottomNavigationBar(
        items: barItem,
        elevation: 0.0,
        currentIndex: _currentIndex,
        onTap: (int value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}
