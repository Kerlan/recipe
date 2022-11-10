import 'favoriteWidget.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:transparent_image/transparent_image.dart';

import 'recipe.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({Key? key, required this.recipe}) : super(key: key);
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    Widget imageSection = Stack(children: [
      Container(
        width: 600,
        height: 240,
        child: const Center(child: CircularProgressIndicator()),
      ),
      FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image: recipe.imageUrl,
          width: 600,
          height: 240,
          fit: BoxFit.cover)
    ]);

    Widget buttonSection = Container(
        padding: const EdgeInsets.all(8),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _buildButtonColumn(Colors.blue, Icons.comment, "COMMENT"),
          _buildButtonColumn(Colors.blue, Icons.share, "SHARE")
        ]));

    Widget descriptionSection = Container(
        padding: const EdgeInsets.all(32),
        child: Text(recipe.description, softWrap: true));

    Widget titleSection = Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(recipe.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20)),
                ),
                Text(recipe.user,
                    style: TextStyle(color: Colors.grey[500], fontSize: 16))
              ],
            )),
            FavoriteWidget(
                isFavorited: recipe.isFavorited,
                favoriteCount: recipe.favoriteCount)
          ],
        ));

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text("Mes recette"),
        ),
        body: ListView(children: [
          imageSection,
          titleSection,
          buttonSection,
          descriptionSection
        ]));
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: Icon(icon, color: color)),
        Text(label,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, color: color))
      ],
    );
  }
}
