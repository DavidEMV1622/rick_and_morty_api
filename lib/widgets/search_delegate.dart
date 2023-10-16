import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_api/providers/api_provider.dart';

import '../models/character_model.dart';

class SearchCharacter extends SearchDelegate {

  @override
  String  get searchFieldLabel => "Search Character";

  // Metodo para un widget a la derecha "IconButton" para borrar el texto de busqueda
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () {
        query = '';
        showSuggestions(context);
      }, icon: const Icon(Icons.clear))
    ];
  }

// Metodo para un widget a la izquierda "IconButton" para regresar a la anterior pantalla
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () {
      close(context, null);
    }, icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  // Metodo para mostrar la lista de personajes a la hora buscarlo
  @override
  Widget buildSuggestions(BuildContext context) {
    final characterProvider = Provider.of<ApiProvider>(context);

    Widget circleLoading() {
      return const Center(
        child: CircleAvatar(
          radius: 100,
          backgroundImage: AssetImage("assets/images/portal_charge.gif")
        ),
      );
    }

    if(query.isEmpty) {
      return circleLoading();
    }

    return FutureBuilder(
      future: characterProvider.getSearchCharacter(query),
      builder: (context, AsyncSnapshot<List<Character>> snapshot) {
        if (!snapshot.hasData) {
          return circleLoading();
        }

        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final character = snapshot.data![index];

            return ListTile(
              onTap: () {
                context.go("/character", extra: character);
              },
              title: Text(character.name!),
              leading: Hero(
                tag: character.id!,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(character.image!),
                ),
                ),
            );
          }
        );
      }
    );
  }

}