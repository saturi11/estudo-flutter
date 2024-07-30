import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NumerosAleatoriosSharedPreferencesPage extends StatefulWidget {
  const NumerosAleatoriosSharedPreferencesPage({super.key});

  @override
  State<NumerosAleatoriosSharedPreferencesPage> createState() =>
      _NumerosAleatoriosSharedPreferencesPageState();
}

class _NumerosAleatoriosSharedPreferencesPageState
    extends State<NumerosAleatoriosSharedPreferencesPage> {
  int numeroAleatorio = 0;
  int quantidade = 0;
  final CHAVE_RANDOM = "randomNum";
  final QUANTIDADE = "quantidade";

  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    final storage = await SharedPreferences.getInstance();
    var randomNum = storage.getInt(CHAVE_RANDOM);
    if (randomNum != null) {
      numeroAleatorio = randomNum;
      setState(() {});
    }
    var qtd = storage.getInt(QUANTIDADE);
    if (qtd != null) {
      quantidade = qtd;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Números Aleatorios'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Números Aleatorios', style: TextStyle(fontSize: 20)),
              Text(numeroAleatorio.toString(), style: TextStyle(fontSize: 30)),
              Text(
                  'Quantidade de vezes que o botão foi pressionado: $quantidade',
                  style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final storage = await SharedPreferences.getInstance();
            quantidade++;
            var random = new Random();
            numeroAleatorio = random.nextInt(200);
            setState(() {});
            storage.setInt(CHAVE_RANDOM, numeroAleatorio);
            storage.setInt(QUANTIDADE, quantidade);
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
