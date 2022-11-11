import 'package:flutter/material.dart';
import 'package:kerlan/components/receipCard.dart';

class Receip extends StatefulWidget {
  const Receip({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ReceipState createState() => _ReceipState();
}

class _ReceipState extends State<Receip> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: RecipeCard(
          title: 'My recipe',
          rating: '4.9',
          cookTime: '30 min',
          thumbnailUrl: 'https://lh3.googleusercontent.com/ei5eF1LRFkkcekhjdR_8XgOqgdjpomf-rda_vvh7jIauCgLlEWORINSKMRR6I6iTcxxZL9riJwFqKMvK0ixS0xwnRHGMY4I5Zw=s360',
        ),);
  }
}