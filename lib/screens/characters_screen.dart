import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/character_model.dart';
import '../providers/api_provider.dart';


class CharactersScreen extends StatelessWidget {

  final Character character;

  const CharactersScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(character.name!),
        centerTitle: true,
      ),

      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        
        child: ListView(
          children: [
            SizedBox(
              height: size.height * 0.37,
              width: double.infinity,
              // "Hero" para que se de correctamente la animacion
              child: Hero(
                tag: character.id!, // Se agrega el valor que define a cada personaje
                child: Image.network(
                  character.image!,
                  fit: BoxFit.cover, // manera en como se va a vizualizar cada imagen 
                )
              ) 
            ),

            Container(
              padding: const EdgeInsets.all(10),
              height: size.height * 0.10,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  cardData("status:", character.status!),
                  cardData("species:", character.species!),
                  cardData("Origin:", character.origin!.name!),
                ]
              ),
            ),

            const Center(
              child: Text("Episodes",
                style: TextStyle(fontSize: 17),
              ),
            ),

            EpisodeList(size: size, character: character)
          ],
        ),
      ),
    );
  }

  Widget cardData(String textOne, String textTwo) {
    return Expanded(child: Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment:  MainAxisAlignment.center,
        children: [
          Text(textOne),
          Text(textTwo),
        ],
      ),
    )); 
  }
}

class EpisodeList extends StatefulWidget {
  final Size size;
  final Character character;

  const EpisodeList({super.key, required this.size, required this.character});

  @override
  State<EpisodeList> createState() => _EpisodeListState();
}

class _EpisodeListState extends State<EpisodeList> {

  @override
  void initState() {
    super.initState();
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    apiProvider.getEpisodesModels(widget.character);
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);
    return SizedBox(
      height: widget.size.height * 0.34,
      child: ListView.builder(
        itemCount: apiProvider.episodes.length,
        itemBuilder: (context, index) {
          final episode = apiProvider.episodes[index];
          return ListTile(
            leading:  Text(episode.episode!),
            title: Text(episode.name!),
            trailing: Text(episode.airDate!),
          );
        }, 
      ),
    );
  }
}