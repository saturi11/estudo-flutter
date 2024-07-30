import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trilhaapp/model/via_cep_model.dart';
import 'package:trilhaapp/repositories/via_cep_repository.dart';

class ConsultaCep extends StatefulWidget {
  const ConsultaCep({super.key});

  @override
  State<ConsultaCep> createState() => _TesteHttpState();
}

class _TesteHttpState extends State<ConsultaCep> {
  var cepController = TextEditingController();
  var viaCepModel = ViaCepModel();
  var viaCepRepository = ViaCepRepository();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            http.get(Uri.parse("https://www.google.com")).then((value) {
              print(value.body);
            }, onError: (error) {
              print(error);
            });
          },
          backgroundColor: const Color.fromARGB(255, 76, 102, 175),
          child: const Icon(Icons.send),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                "Consulta CEP",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: AutofillHints.addressCity,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              TextField(
                maxLength: 8,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Digite o CEP",
                ),
                controller: cepController,
                onChanged: (String value) async {
                  if (value.length == 8) {
                    setState(() {
                      isLoading = true;
                    });
                    viaCepModel = await viaCepRepository.obterEndereco(value);
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
              ),
              if (isLoading) const CircularProgressIndicator(),
              const SizedBox(height: 30),
              Text("CEP: ${viaCepModel.cep}"),
              Text("logradouro: ${viaCepModel.logradouro}"),
              Text("bairro: ${viaCepModel.bairro}"),
              Text("uf: ${viaCepModel.uf}"),
            ],
          ),
        ),
      ),
    );
  }
}
