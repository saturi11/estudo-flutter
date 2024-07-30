import 'package:flutter/material.dart';
import 'package:trilhaapp/model/cardDetail.dart';

class CardDetailPage extends StatelessWidget {
  final Carddetail cardDetail;

  const CardDetailPage({super.key, required this.cardDetail});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: cardDetail.id,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
              Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Image.network(
                        cardDetail.url,
                        height: 100,
                      ),
                    ],
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: Expanded(
                  child: Text(
                    cardDetail.text,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: const Expanded(
                  child: Text(
                      "Dentro das quatro linhas, foi vestindo o manto tricolor que o goleiro Caxambu inventou a ponte, que Roberto Dias tornou-se o maior marcador de Pelé, que Raí e Telê comemoraram a vitória sobre o Barcelona, que Müller marcou o gol que fez o italiano Costacurta perder o rumo de Milão, que Rogério Ceni passou a ser o Maior Goleiro Artilheiro do Mundo, além de tantos outros grandes momentos da gloriosa trajetória são-paulina!"),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: const Expanded(
                  child: Text(
                      "Foi também defendendo as cores do São Paulo que o saltador Adhemar Ferreira da Silva chegou ao ouro olímpico e bateu duas vezes o recorde mundial do salto triplo, e que Éder Jofre, o Galo de Ouro dos 50 nocautes, surgiu para os ringues que um dia estariam a seus pés."),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
