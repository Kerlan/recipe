import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecipeList extends StatefulWidget {
  const RecipeList({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  _RecipeListState() {
    takeListWidget();
  }

  dynamic jsonList = [];
  Future<void> takeListWidget() async {
    var client = http.Client();

    try {
      var response = await http.get(
        Uri.parse(
            "https://flutter-recipes-epitech.herokuapp.com/recipes/personal/recipes"),
        headers: <String, String>{
          'Accept': '*/*',
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization":
              "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImtAay5jb20iLCJ1c2VySWQiOiI2MzY4Y2Q3YzAwMGJkZDhhNDcwODY5NTEiLCJuYW1lIjoia2VybGFuIiwicm9sZSI6MiwiaWF0IjoxNjY3ODE4MjA4LCJleHAiOjE2Njg0MjMwMDh9.Z9k9b8WEl9etJQIUrhCNdnjzVB6Q4Xc33rUmsDGXoLM",
        },
      );
      print(response.body);

      // var response = await http.get(
      //   Uri.parse(url),
      // );
      setState(() {
        jsonList = json.decode(response.body);
      });

      //  setState(() {
      //  jsonList = jsonTmp;
      //});
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    Widget imageSection = Container(
      padding: const EdgeInsets.all(8),
      width: 600,
      height: 240,
      child: const Center(
          child: Image(
        image: NetworkImage(
            'https://assets.afcdn.com/recipe/20160519/15342_w1280h972c1cx3504cy2338.webp'),
      )),
    );

    Widget textSection = Container(
      child: const Center(child: Text('Pizza 12€')),
    );

    Widget card = Container(
      child: Column(
        children: [imageSection, textSection],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the RecipeList object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: jsonList.length,
          itemBuilder: (BuildContext context, int index) {
            if (jsonList[index]["pictures"].length > 0) {
              return Container(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      width: 600,
                      height: 240,
                      child: Center(
                        child: Image.network(jsonList[index]["pictures"][0]),
                      ),
                    ),
                    Container(
                      child: Center(child: Text(jsonList[index]["name"])),
                    ),
                  ],
                ),
              );
            } else
              return Container();
            ;
          },
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
