import 'package:flutter/material.dart';
import '../models/character_model.dart';
import 'package:http/http.dart' as http;

import '../models/episode_model.dart'; 

class ApiProvider with ChangeNotifier{
  final url = "rickandmortyapi.com";
  List<Character> characters = [];
  List<EpisodeModel> episodes = [];

  Future<void> getCharacters(int page) async {
    final result = await http.get(Uri.https(url, "/api/character", {"page" : page.toString(),}));
    final response = characterModelFromJson(result.body);
    //print(response.results);
    characters.addAll(response.results!);
    notifyListeners();
  }

  Future<List<EpisodeModel>> getEpisodesModels(Character character) async {
    episodes = [];
    for (var i = 0; i < character.episode!.length; i++) {
      final result = await http.get(Uri.parse(character.episode![i]));
      final response = episodeModelFromJson(result.body);
      episodes.add(response);
      notifyListeners();
    }
    return episodes;
  }

  Future<List<Character>> getSearchCharacter(String name) async {
    final result = await http.get(Uri.https(url, "/api/character/", {"name": name}));
    final response = characterModelFromJson(result.body);
    return response.results!;
  }
}