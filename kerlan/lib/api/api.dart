// ignore_for_file: always_specify_types

import 'dart:convert';

import 'package:kerlan/class/Receip.dart';
import 'package:http/http.dart' as http;

// ALL API CALLS ARE HERE

String url = "https://flutter-recipes-epitech.herokuapp.com";
String? bearerToken;

// ignore: always_declare_return_types
headers() {
  Map<String, String> apiHeader = {};
  apiHeader = {"Content-Type": "application/json"};

  if (bearerToken != null) {
    apiHeader = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $bearerToken"
    };
  }
  return apiHeader;
}

/////////////////////LOGIN/REGISTER///////////////////////////////

Future<http.Response> loginUser(String email, String password,) async {
  final String body = jsonEncode({"email": email, "password": password});
  final Uri loginUrl = Uri.parse("$url/users/login");

  final http.Response response = await http.post(
    loginUrl,
    headers: headers(),
    body: body,
  );
  return response;
}

Future<http.Response> registerUser(
    String name, String email, String password,) async {
  final String body =
      jsonEncode({"name": name, "email": email, "password": password, "picture": ""});
  final Uri registerUrl = Uri.parse("$url/users/register");

  final http.Response response = await http.post(
    registerUrl,
    headers: headers(),
    body: body,
  );
  return response;
}

class RecipeApi {
  static Future<List<Recipe>> getRecipe() async {
    final Uri uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list',
        {"limit": "18", "start": "0", "tag": "list.recipe.popular"},);

    final http.Response response = await http.get(uri, headers: {
      "x-rapidapi-key": "YOUR API KEY FROM YUMMLY API",
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "useQueryString": "true"
    },);

    final Map data = jsonDecode(response.body);
    final List temp = [];

    for (var i in data['feed']) {
      temp.add(i['content']['details']);
    }

    return Recipe.recipesFromSnapshot(temp);
  }
}