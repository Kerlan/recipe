import 'dart:ui';

import 'package:flutter/material.dart';
import 'addRecipePage.dart';

class NavBar extends StatefulWidget {
  @override
  const NavBar({
    Key? key,
  }) : super(key: key);

  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<Widget> _widgetOptions = <Widget>[
    AddRecipePage(),
    //Text("dsqd"),
    AddRecipePage(),
    AddRecipePage(),
  ];

//  final ScrollController _scrollController = ScrollController();
  _NavBarState() {
    _widgetOptions = <Widget>[
      AddRecipePage(),
      //Text("dsqd"),
      AddRecipePage(),
      AddRecipePage(),
    ];
    //saveIndex = index;
  }
  int _selectedIndex = 1;

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Ajouter un produit",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.clear),
              color: Colors.black,
              onPressed: () => {
                    Navigator.pop(context, false),
                  }),
        ),
        body: BottomNavigationBar(
          selectedIconTheme: IconThemeData(color: Colors.blue),
          selectedItemColor: Color.fromARGB(255, 116, 160, 195),
          unselectedItemColor: Colors.black,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.fact_check,
              ),
              label: 'Commandes',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.dashboard,
              ),
              label: 'Tableau de bord',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.checkroom,
              ),
              //backgroundColor: Colors.white,
              label: 'Produits',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
          selectedFontSize: 13.0,
          unselectedFontSize: 13.0,
        ));
  }
}
