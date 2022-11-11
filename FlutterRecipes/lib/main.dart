import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterRecipes/pages/auth/Login.dart';
import 'package:flutterRecipes/pages/auth/Register.dart';
import 'package:flutterRecipes/pages/pages/dashboard.dart';
import 'package:page_transition/page_transition.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Add this

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Recipes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode.light,
      initialRoute: '/',
      routes: <String, Widget Function(BuildContext)>{
        '/login': (BuildContext context) => const Login(),
        '/register': (BuildContext context) => const Register(),
        '/dashboard': (BuildContext context) => const Dashboard(),
      },
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: const Text(
                  "Bienvenue sur Flutter Recipes",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 400,
                height: 300,
                child: Center(
                  child: Image(
                    image: AssetImage('assets/recipe.png'),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 50, bottom: 15.0),
                height: 50.0,
                child: GestureDetector(
                  onTap: () {
                    // ignore: always_specify_types
                    Navigator.push(
                      context,
                      // ignore: always_specify_types
                      PageTransition(
                        child: const Login(),
                        type: PageTransitionType.rightToLeftWithFade,
                        duration: const Duration(milliseconds: 500),
                      ),
                    );
                  },
                  child: Container(
                    width: 350,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Center(
                          child: Text(
                            "Connexion",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 15.0),
                height: 50.0,
                child: GestureDetector(
                  onTap: () {
                    // ignore: always_specify_types
                    Navigator.push(
                      context,
                      // ignore: always_specify_types
                      PageTransition(
                        child: const Register(),
                        type: PageTransitionType.rightToLeftWithFade,
                        duration: const Duration(milliseconds: 500),
                      ),
                    );
                  },
                  child: Container(
                    width: 350,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Center(
                          child: Text(
                            "Inscription",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
