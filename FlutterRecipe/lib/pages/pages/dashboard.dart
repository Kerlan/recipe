import 'package:flutter/material.dart';
import 'package:flutterRecipes/pages/pages/listView.dart';
import 'package:flutterRecipes/pages/pages/profile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<Dashboard> {
  int _selectedPage = 0;
  static const List<Widget> _navigationPages = <Widget>[
    RecipeList(title: "Recipes"),
    Text("data"),
    Profil(),
  ];

  void _onNavigationTap(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: _navigationPages.elementAt(_selectedPage),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "?"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil")
          ],
          currentIndex: _selectedPage,
          onTap: _onNavigationTap,
        ),
        
        
      ),
    );
  }
}
