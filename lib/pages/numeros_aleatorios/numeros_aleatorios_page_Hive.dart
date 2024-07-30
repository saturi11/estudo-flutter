import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NumerosAleatoriosHivePage extends StatefulWidget {
  const NumerosAleatoriosHivePage({super.key});

  @override
  State<NumerosAleatoriosHivePage> createState() =>
      _NumerosAleatoriosHivePageState();
}

class _NumerosAleatoriosHivePageState extends State<NumerosAleatoriosHivePage> {
  late Box storages;
  int numeroAleatorio = 0;
  int quantidade = 0;

  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    storages = await Hive.openBox('numerosAleatorios');

    numeroAleatorio = storages.get('numeroAleatorio') ?? 0;
    quantidade = storages.get('quantidade') ?? 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Números Aleatorios com Hive'),
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
            quantidade++;
            var random = new Random();
            numeroAleatorio = random.nextInt(200);
            setState(() {});
            storages.put('numeroAleatorio', numeroAleatorio);
            storages.put('quantidade', quantidade);
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
