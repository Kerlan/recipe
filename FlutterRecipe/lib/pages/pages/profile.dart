// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterRecipes/class/User.dart';
import 'package:image_picker/image_picker.dart';

class Profil extends StatefulWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  ProfilPageState createState() => ProfilPageState();
}

class ProfilPageState extends State<Profil> {
  final GlobalKey<FormState> _profilKey = GlobalKey<FormState>();
  UserData userInfo = UserData.fromJson(jsonUserInfos);
  String firstName = "";
  String userPassword = "";
  String userEmail = "";
  bool isLoading = false;
  // ignore: always_specify_types, prefer_typing_uninitialized_variables
  var imageFile;

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  @override
  void dispose() {
    super.dispose();
  }
  // _editUserData(firstName, lastName, userEmail) async {
  //   try {
  //     var response = await editUserData(userEmail, firstName, lastName,
  //         dashboardConfig, createdAt, updatedAt);
  //     if (response.statusCode == 200) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //             backgroundColor: Colors.green,
  //             content: Text('Profil modifié avec succès')),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //             backgroundColor: Colors.red,
  //             content: Text('Erreur, modification impossible')),
  //       );
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  Widget _imageDisplay() {
    if (imageFile != null) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Image.file(
          imageFile,
          fit: BoxFit.cover,
          width: 200.0,
          height: 200.0,
        ),
      );
    } else {
      return const Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          size: 150,
        ),
      );
    }
  }

  void _getFromGallery() async {
    final PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  void _getFromCamera() async {
    final PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _profilKey,
          child: Wrap(
            runSpacing: 25.0,
            children: <Widget>[
              // Container(
              //   margin: const EdgeInsets.only(bottom: 30.0),
              //   child: const Center(
              //     child: Text(
              //       "Mon profil",
              //       style:
              //           TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 200.0,
                      height: 200.0,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                      child: _imageDisplay(),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 25, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: OutlinedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.orange),
                        ),
                        onPressed: () {
                          _getFromGallery();
                        },
                        child: const Text(
                          "Gallerie",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.orange),
                      ),
                      onPressed: () {
                        _getFromCamera();
                      },
                      child: const Text(
                        "Caméra",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 30),
                child: TextFormField(
                  initialValue: userInfo.user!.name,
                  onChanged: (String? value) {
                    setState(() {
                      firstName = value.toString();
                    });
                  },
                  keyboardType: TextInputType.text,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Remplissez un prénom";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Prénom",
                    hintMaxLines: 1,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 30),
                child: TextFormField(
                  initialValue: userInfo.user!.email,
                  onChanged: (String value) {
                    setState(() {
                      userEmail = value;
                    });
                  },
                  keyboardType: TextInputType.text,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Remplissez un mail";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Email",
                    hintMaxLines: 1,
                  ),
                ),
              ),
              // Container(
              //   margin: const EdgeInsets.only(left: 15, right: 30, bottom: 30),
              //   child: TextFormField(
              //     initialValue: userInfo.user.,
              //     onChanged: (String value) {
              //       setState(() {
              //         userPassword = value;
              //       });
              //     },
              //     keyboardType: TextInputType.text,
              //     validator: (String? value) {
              //       if (value == null || value.isEmpty) {
              //         return "Remplissez un email";
              //       }
              //       return null;
              //     },
              //     decoration:
              //         const InputDecoration(hintText: "Email", hintMaxLines: 1),
              //   ),
              // ),
            ],
          ),
        ),

        // Container(
        //   alignment: Alignment.bottomRight,
        //   margin: EdgeInsets.only(top: 100.0, right: 15),
        //   // ignore: deprecated_member_use
        //   child: NeumorphicButton(
        //     child: Text("Envoyer",
        //         style: TextStyle(fontWeight: FontWeight.bold)),
        //     onPressed: () async {
        //       if (_profilKey.currentState.validate()) {
        //         _editUserData(firstName, lastName, userEmail);
        //       }
        //     },
        //     style: NeumorphicStyle(
        //         depth: 8,
        //         lightSource: LightSource.top,
        //         color: Colors.white,
        //         shadowDarkColor: Colors.black),
        //   ),
        // ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 380,
        child: FloatingActionButton.extended(
          label: const Text(
            "Modifier",
            style: TextStyle(fontSize: 18),
          ),
          backgroundColor: Colors.orange,
          onPressed: () {},
        ),
      ),
    );
  }
}
