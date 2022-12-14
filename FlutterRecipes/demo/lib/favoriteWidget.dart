import 'package:flutter/material.dart';

class FavoriteWidget extends StatefulWidget {
  final bool isFavorited;
  final int favoriteCount;

  const FavoriteWidget ({Key? key, required this.isFavorited, required this.favoriteCount}) : super(key: key);
  _FavoriteWidget createState() => _FavoriteWidget(this.isFavorited, this.favoriteCount);
}

class _FavoriteWidget extends State<FavoriteWidget> {
  bool _isFavorited;
  int _favoriteCount;

  _FavoriteWidget(this._isFavorited, this._favoriteCount);

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _isFavorited = false;
        _favoriteCount -= 1;
      } else {
        _isFavorited = true;
        _favoriteCount += 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: _isFavorited ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
          color: Colors.red,
          onPressed: _toggleFavorite
          ),
        Text("$_favoriteCount")
      ],
    );
  }
}