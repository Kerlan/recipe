// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterRecipes/api/api.dart';
import 'package:flutterRecipes/class/User.dart';
import 'package:flutterRecipes/pages/auth/Register.dart';
import 'package:page_transition/page_transition.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<Login> {
  String email = "";
  String password = "";
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxHeight: 1000, maxWidth: 1000),
          margin: const EdgeInsets.only(
            left: 40.0,
            right: 40.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Center(
                  child: Text(
                    "Connecte toi !",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: _loginKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.greenAccent),
                          ),
                          prefixIcon: Icon(Icons.email),
                          hintText: "Email",
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          enabledBorder: OutlineInputBorder(),
                        ),
                        onChanged: (String value) {
                          setState(() => email = value);
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Remplissez votre email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.greenAccent),
                          ),
                          prefixIcon: Icon(Icons.lock),
                          hintText: "Mot de passe",
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          enabledBorder: OutlineInputBorder(),
                        ),
                        onChanged: (String value) {
                          setState(() => password = value);
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Remplissez votre mot de passe';
                          }
                          return null;
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 50, bottom: 15.0),
                        height: 50.0,
                        child: GestureDetector(
                          onTap: () {
                            if (_loginKey.currentState!.validate()) {
                              handleChange(email, password);
                            }
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 380,
        child: FloatingActionButton.extended(
          label: const Text("Pas de compte ?"),
          backgroundColor: Colors.black,
          onPressed: () {
            Navigator.push(
              context,
              // ignore: always_specify_types
              PageTransition(
                child: const Register(),
                type: PageTransitionType.bottomToTop,
                duration: const Duration(milliseconds: 400),
              ),
            );
          },
        ),
      ),
    );
  }

  // ignore: always_declare_return_types
  handleChange(String email, String password) async {
    try {
      // ignore: always_specify_types
      final userData = await loginUser(email, password);
      if (userData.statusCode == 200) {
        jsonUserInfos = json.decode(userData.body);
        // ignore: use_build_context_synchronously
        await Navigator.pushReplacementNamed(context, "/dashboard");
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text("Impossible de ce connecter au compte"),
          ),
        );
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
}
