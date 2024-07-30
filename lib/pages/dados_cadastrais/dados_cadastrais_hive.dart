import 'package:flutter/material.dart';
import 'package:trilhaapp/model/dados_cadastrais.dart';
import 'package:trilhaapp/repositories/dados_cadastrais_repository.dart';
import 'package:trilhaapp/repositories/linguagens_repository.dart';
import 'package:trilhaapp/repositories/nivel_repository.dart';
import 'package:trilhaapp/shared/widgets/text_label.dart';

class DadosCadastraisHive extends StatefulWidget {
  const DadosCadastraisHive({Key? key}) : super(key: key);

  @override
  State<DadosCadastraisHive> createState() => _DadosCadastraisHiveState();
}

class _DadosCadastraisHiveState extends State<DadosCadastraisHive> {
  late DadosCadastraisRepository dadosCadastraisRepository;
  var dadosCadastrais = DadosCadastrais.vazio();

  TextEditingController nomeController = TextEditingController(text: "");
  TextEditingController dataController = TextEditingController(text: "");

  var nivelRepository = NivelRepository();
  var niveis = [];

  var linguagensRepository = LinguagensRepository();
  var linguagens = [];

  bool salvando = false;

  @override
  void initState() {
    super.initState();
    niveis = nivelRepository.getNivel();
    linguagens = linguagensRepository.getLinguagens();
    carregarDados();
  }

  carregarDados() async {
    dadosCadastraisRepository =
        await DadosCadastraisRepository.loadRepository();
    dadosCadastrais = dadosCadastraisRepository.load();

    nomeController.text = dadosCadastrais.nome ?? "";
    dataController.text = dadosCadastrais.dataNascimento == null
        ? ""
        : "${dadosCadastrais.dataNascimento!.day}/${dadosCadastrais.dataNascimento!.month}/${dadosCadastrais.dataNascimento!.year}";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meus Dados")),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: salvando
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  const TextLabel(text: 'Nome'),
                  TextField(controller: nomeController),
                  const TextLabel(text: "Data de nascimento"),
                  TextField(
                    controller: dataController,
                    readOnly: true,
                    onTap: () async {
                      var data = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900, 1, 1),
                        lastDate: DateTime.now(),
                      );
                      if (data != null) {
                        setState(() {
                          dadosCadastrais.dataNascimento = data;
                          dataController.text =
                              "${data.day}/${data.month}/${data.year}";
                        });
                      }
                    },
                  ),
                  const TextLabel(text: 'Nivel de conhecimento'),
                  Column(
                    children: niveis
                        .map((nivel) => RadioListTile(
                              title: Text(nivel.toString()),
                              selected:
                                  dadosCadastrais.nivelExperiencia == nivel,
                              value: nivel.toString(),
                              groupValue: dadosCadastrais.nivelExperiencia,
                              onChanged: (value) {
                                setState(() {
                                  dadosCadastrais.nivelExperiencia =
                                      value.toString();
                                });
                              },
                            ))
                        .toList(),
                  ),
                  const TextLabel(text: "Linguagens de programação dominadas"),
                  Column(
                    children: linguagens
                        .map((linguagem) => CheckboxListTile(
                              title: Text(linguagem),
                              value: dadosCadastrais.linguagens
                                  .contains(linguagem),
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value!) {
                                    dadosCadastrais.linguagens.add(linguagem);
                                  } else {
                                    dadosCadastrais.linguagens
                                        .remove(linguagem);
                                  }
                                });
                              },
                            ))
                        .toList(),
                  ),
                  const TextLabel(text: "Tempo de experiência"),
                  DropdownButton(
                    value: dadosCadastrais.tempoExperiencia,
                    isExpanded: true,
                    items: List.generate(
                      11,
                      (index) => DropdownMenuItem(
                        value: index,
                        child: Text("$index anos"),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        dadosCadastrais.tempoExperiencia =
                            int.parse(value.toString());
                      });
                    },
                  ),
                  TextLabel(
                      text:
                          "Pretenção salarial, R\$ ${dadosCadastrais.salario?.round()}"),
                  Slider(
                    min: 0,
                    max: 10000,
                    value: dadosCadastrais.salario ?? 0,
                    onChanged: (double value) {
                      setState(() {
                        dadosCadastrais.salario = value;
                      });
                    },
                  ),
                  TextButton(
                    onPressed: () async {
                      setState(() {
                        salvando = true;
                      });
                      dadosCadastraisRepository.salvar(dadosCadastrais);
                      setState(() {
                        salvando = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Dados salvos com sucesso'),
                      ));
                      Navigator.pop(context);
                    },
                    child: const Text("Salvar"),
                  ),
                ],
              ),
      ),
    );
  }
}
