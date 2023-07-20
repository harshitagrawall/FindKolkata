import 'package:flutter/material.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view/about_us.dart';
import 'package:mvvm/view/privacy.dart';
import 'package:mvvm/view/search_screen.dart';
import 'package:mvvm/view/terms_and_conditions.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  int currentindex = 0;
  var screens = [
    SearchScreen(),
    TandC(),
    Privacy(),
    AboutUs(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: currentindex,
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.blue.shade600,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          onTap: (_index) {
            Utils.removeFocus(context);
            setState(() {
              currentindex = _index;
            });
          },
          // elevation: 10,
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.deepOrangeAccent,
              label: 'T&C',
              icon: Icon(Icons.book_online),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.deepOrangeAccent,
              // activeIcon: ListView(),
              label: 'Privacy',
              icon: Icon(
                Icons.card_travel,
              ),
            ),
            BottomNavigationBarItem(
              label: 'ABout Us',
              backgroundColor: Colors.deepOrangeAccent,
              icon: Icon(Icons.person),
            ),
          ],
          currentIndex: currentindex,
        ));
  }
}
