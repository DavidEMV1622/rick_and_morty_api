import 'package:flutter/material.dart';
import '../models/character_model.dart';
import 'package:http/http.dart' as http; 

class ApiProvider with ChangeNotifier{
  final url = "rickandmortyapi.com";
  List<Character> characters = [];

  Future<void> getCharacters(int page) async {
    final result = await http.get(Uri.https(url, "/api/character", {"page" : page.toString(),}));
    final response = characterModelFromJson(result.body);
    print(response.results);
    characters.addAll(response.results!);
    notifyListeners();
  }
}