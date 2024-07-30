import 'package:flutter/material.dart';
import 'package:trilhaapp/model/characters_model.dart';
import 'package:trilhaapp/repositories/marvel/marvel_api_repository.dart';

class HerosPage extends StatefulWidget {
  const HerosPage({Key? key});

  @override
  State<HerosPage> createState() => _HerosPageState();
}

class _HerosPageState extends State<HerosPage> {
  ScrollController _scrollController = ScrollController();
  late MarvelApiRepository marvelApiRepository;
  CharacterModel character = CharacterModel();
  int offset = 0;
  var carregando = false;

  int quantidadeTotal() {
    if (character.data == null || character.data!.results == null) {
      return 0;
    }
    return character.data!.results!.length;
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      print(_scrollController.position.pixels);
      print(_scrollController.position.maxScrollExtent);
    });
    marvelApiRepository = MarvelApiRepository();
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    if (character.data == null || character.data!.results == null) {
      carregando = true;
      setState(() {});
      character = await marvelApiRepository.getCharacters(offset);
      carregando = false;
    } else {
      carregando = true;
      setState(() {});
      offset = offset + character.data!.count!;
      var tempList = await marvelApiRepository.getCharacters(offset);
      character.data!.results!.addAll(tempList.data!.results!);
      carregando = false;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Herois: ${quantidadeTotal()}"),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: (character.data == null ||
                          character.data!.results == null)
                      ? 0
                      : character.data!.results!.length,
                  itemBuilder: (_, int index) {
                    return Card(
                      child: Row(
                        children: [
                          Image.network(
                            character.data!.results![index].thumbnail!.path! +
                                "." +
                                character.data!.results![index].thumbnail!
                                    .extension!,
                            width: 100,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  character.data!.results![index].name!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  character.data!.results![index].description!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            !carregando
                ? ElevatedButton(
                    onPressed: () {
                      carregarDados();
                    },
                    child: Text("Carregar mais"))
                : CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
