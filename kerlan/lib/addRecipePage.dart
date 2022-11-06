import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'recipe.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'api/firebase_take_file.dart';

class AddRecipePage extends StatefulWidget {
  @override
  const AddRecipePage({
    Key? key,
  }) : super(key: key);

  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
//  final ScrollController _scrollController = ScrollController();
  String nomValue = "";
  String descValue = "";
  int validator = 0;
  final ScrollController _scrollController = ScrollController();
  List<File> imageFile = [];
  bool imageFill = false;
  final picker = ImagePicker();
  chooseImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(
      source: source,
      imageQuality: 50,
    );
    if (pickedFile != null)
      setState(() {
        validator = 0;
        imageFile.add(File(pickedFile.path));
        imageFill = true;
      });
  }

  Future<void> sendProduct() async {
    // var client = http.Client();
    var dio = Dio();

    // print(logList);
    try {
      final destination = "recipe/photo/" + nomValue;

      var result = FirebaseApi.uploadFile(destination, imageFile[0]);
      print(result);
      // var response = await dio
      //     .post('https://flutter-recipes-epitech.herokuapp.com/', data: {
      //   nomValue,
      //   "Kerlan PLUMASSEAU",
      //   "gs://yomy-cfc3f.appspot.com/Recipe/photo/" + nomValue,
      //   descValue,
      //   false,
      //   32
      // });
      // var url =
      //     "https://us-central1-yomy-cfc3f.cloudfunctions.net/productManageFit-user/fittinghome";
      // var response = await http.post(Uri.parse(url), body: data);
      // var jsonList = json.decode(response.body);
      // for (int i = 0; imageFile.length != i; i++) {
      //   print("dsqdsdsq");
      //}
    } finally {
      //  client.close();
      //Navigator.of(context).pop();
    }
  }

  // late File imageFile;
  _AddRecipePageState();
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              imageFill != false
                  ? SizedBox(
                      height: 230,
                      child: SizedBox(
                        height: 250,
                        // width: double.infinity,
                        child: Stack(
                            alignment: Alignment.topRight,
                            children: <Widget>[
                              Container(
                                child: Image.file(
                                  imageFile[0],
                                  height: 200,
                                  width: 200,
                                ),
                              ),
                              Container(
                                height: 30,
                                width: 30,
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.black38,
                                ),
                                child: IconButton(
                                  // splashColor: Colors.transparent,
                                  // highlightColor: Colors.transparent,
                                  padding: EdgeInsets.zero,
                                  icon: Icon(
                                    Icons.clear,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      imageFile.removeAt(0);
                                      if (imageFile.length == 0) {
                                        imageFill = false;
                                        validator = 1;
                                      }
                                    });
                                  },
                                ),
                              ),
                            ]),
                      ))
                  : Container(
                      height: 100,
                      width: 100,
                      child: Text("nophoto"),
                    ),
              Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                        onPressed: () {
                          chooseImage(ImageSource.camera);
                        },
                        color: Color.fromARGB(255, 76, 159, 227),
                        child: Text(
                          "Caméra",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                        onPressed: () {
                          chooseImage(ImageSource.gallery);
                        },
                        color: Color.fromARGB(255, 76, 159, 227),
                        child: Text(
                          "Galerie*",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: TextFormField(
                  onChanged: (text) {
                    nomValue = text;
                  },
                  validator: (value) {
                    if (value == null || value.length == 0) {
                      return 'Veuillez entrez un nom';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(93, 0, 0, 0), width: 2),
                    ),
                    labelText: 'Nom du produit *',
                    labelStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      //    color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: TextFormField(
                  onChanged: (text) {
                    descValue = text;
                  },
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(93, 0, 0, 0), width: 2),
                    ),
                    labelText: 'Description',
                    labelStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      //  color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                width: 300,
                child: FlatButton(
                  onPressed: () {
                    // setState(() {
                    //   if (imageFile.length == 0) validator = 1;
                    // });
                    // if (_formKey.currentState!.validate() &&
                    //     imageFile.length >= 1) {
                    //   // If the form is valid, display a snackbar. In the real world,
                    //   // you'd often call a server or save the information in a database.
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(content: Text('Envoi en cours...')),
                    //   );
                    sendProduct();
                    // } else
                    //   checkValidator = 1;
                    // }
                    //chooseImage(ImageSource.gallery);
                  },
                  color: Color.fromARGB(255, 76, 159, 227),
                  child: Text(
                    "Ajouter",
                    style: TextStyle(color: Colors.white),
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
