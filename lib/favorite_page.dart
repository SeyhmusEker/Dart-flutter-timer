import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FavoritePage extends StatefulWidget {
  late List<String>? fav = [];
  FavoritePage({super.key, fav});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  get fav => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey[800],
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: const Text(
            "Favoriler",
            style: TextStyle(fontSize: 24),
          ),
        ),
        body: Column(
          children: [
            ListView.builder(
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Text(
                      "${index + 1}. Tur --> ${fav[index]}",
                    ),
                  ],
                );
              },
            )
          ],
        ));
  }
}
