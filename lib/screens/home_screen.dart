import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_api/providers/api_provider.dart';
import 'package:rick_and_morty_api/widgets/search_delegate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final scrollController = ScrollController();
  bool isLoading = false;
  int page = 1;

  @override
  void initState() {
    super.initState();
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    apiProvider.getCharacters(page);

    scrollController.addListener(() async {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        setState(() {
          isLoading = true;
        });

      page++;
      await apiProvider.getCharacters(page);
      setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final apiProvider = Provider.of<ApiProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Rick and Morty HOME",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,

        // Boton de "Lupa" para buscar personaje
        actions: [
          IconButton(onPressed: () {
            showSearch(context: context, delegate: SearchCharacter());
          }, icon: const Icon(Icons.search))
        ],
      ),

      body: SizedBox(
        height: double.infinity,
        width: double.infinity,

        child: apiProvider.characters.isNotEmpty 
        ? CharacterList(
          scrollController: scrollController,
          apiProvider: apiProvider,
          isLoading: isLoading,
          )
        : const Center(
          child: CircularProgressIndicator(),
        )
      ),
    );
  }
}
class CharacterList extends StatelessWidget {

  final ApiProvider apiProvider;
  final ScrollController scrollController;
  final bool isLoading;
  
  const CharacterList({super.key, required this.apiProvider, required this.scrollController, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.89, // Espacio que abarca cada Card
        crossAxisSpacing: 15, // Separacion lateral entre cada Card
        mainAxisSpacing: 15, // Separacion superior e inferior entre cada Card
      ),
      itemCount: isLoading ? apiProvider.characters.length + 2 : apiProvider.characters.length,
      controller: scrollController,

      itemBuilder: (context, index) {
        if (index < apiProvider.characters.length){
          final character = apiProvider.characters[index];
          return GestureDetector(
            onTap: () {
              context.push('/character', extra: character);
            },
            child: Card(
              child: Column(children: [

                // "Hero" animación de desplazamiento al seleccionar un personaje
                Hero(
                  tag: character.id!, // Se agrega el valor que define a cada personaje
                  child: FadeInImage(
                    placeholder: const AssetImage("assets/images/portal_charge.gif"), 
                    image: NetworkImage(character.image!)
                  ),
                ),

                Text(character.name!, 
                  style: const TextStyle(
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis
                  ),
                ),
                //Image(image: ,)
              ]),
            )
          );
        }
        else {
          return const Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}