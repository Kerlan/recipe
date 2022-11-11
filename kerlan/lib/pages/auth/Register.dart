// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:kerlan/api/api.dart';
import 'package:kerlan/pages/auth/Login.dart';
import 'package:http/http.dart';
import 'package:page_transition/page_transition.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<Register> {
  String email = "";
  String password = "";
  String name = "";
  final GlobalKey<FormState> _registerKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxHeight: 500, maxWidth: 500),
            margin: const EdgeInsets.only(
              left: 40.0,
              right: 40.0,
            ),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                const Center(
                  child: Text(
                    "Inscrit toi !",
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
                  key: _registerKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.greenAccent),
                        ),
                          prefixIcon: Icon(Icons.person),
                          hintText: "Prénom",
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          enabledBorder: OutlineInputBorder(),
                        ),
                        onChanged: (String value) {
                          setState(() => name = value);
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Remplissez votre nom';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.greenAccent),
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
                          borderSide:
                              BorderSide(color: Colors.greenAccent),
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
                            if (_registerKey.currentState!.validate()) {
                              handleChange(name, email, password);
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
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          width: 380,
          child: FloatingActionButton.extended(
            label: const Text("Déja un compte ?"),
            backgroundColor: Colors.black,
            onPressed: () =>
                // ignore: always_specify_types
                Navigator.push(
                    context,
                    // ignore: always_specify_types
                    PageTransition(
                        child: const Login(), type: PageTransitionType.topToBottom, duration: const Duration(milliseconds: 400),),),
          ),
        ),
      ),
    );
  }

  // ignore: always_declare_return_types
  handleChange(
      String lname, String lemail, String lpassword,) async {
    try {
      final Response userData = await registerUser(lname, lemail, lpassword);
      if (userData.statusCode == 200) {
        // ignore: use_build_context_synchronously
        await Navigator.pushReplacementNamed(context, "/login");
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text("Impossible de ce créer un compte"),
          ),
        );
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
}
