import 'package:flutter/material.dart';

import '../models/character_model.dart';


class CharactersScreen extends StatelessWidget {

  final Character character;

  const CharactersScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name!),
        centerTitle: true,
      ),

      body: SizedBox(
        height: 200,
        width: double.infinity,

        child: Hero(
          tag: character.id!, 
          child: Image.network(character.image!)
        ) 
      ),
    );
  }
}