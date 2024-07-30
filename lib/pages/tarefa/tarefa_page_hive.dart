import 'package:flutter/material.dart';
import 'package:trilhaapp/model/tarefa_hive_model.dart';
import 'package:trilhaapp/repositories/tarefe_hive_repository.dart';

class TarefaHivePage extends StatefulWidget {
  const TarefaHivePage({super.key});

  @override
  State<TarefaHivePage> createState() => _TarefaHivePageState();
}

class _TarefaHivePageState extends State<TarefaHivePage> {
  late TarefeHiveRepository tarefaRepository;
  var _tarefas = const <TarefaHiveModel>[];
  TextEditingController descricaoController = TextEditingController();
  var apenasNaoConcluidas = false;

  void initState() {
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async {
    tarefaRepository = await TarefeHiveRepository.carregar();

    _tarefas = tarefaRepository.obterDados(apenasNaoConcluidas);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              descricaoController.text = '';
              showDialog(
                  context: context,
                  builder: (BuildContext bc) {
                    return AlertDialog(
                      title: Text('Adicionar Tarefa'),
                      content: TextField(
                        controller: descricaoController,
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancelar')),
                        TextButton(
                            onPressed: () async {
                              await tarefaRepository.salvar(
                                  TarefaHiveModel.criar(
                                      descricaoController.text, false));
                              Navigator.pop(context);
                              obterTarefas();
                              setState(() {});
                            },
                            child: Text('Salvar')),
                      ],
                    );
                  });
            },
            child: Icon(Icons.add)),
        body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Tarefas não concluídas",
                      style: TextStyle(fontSize: 18),
                    ),
                    Switch(
                        value: apenasNaoConcluidas,
                        onChanged: (bool value) {
                          apenasNaoConcluidas = value;
                          obterTarefas();
                        }),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: _tarefas.length,
                    itemBuilder: (BuildContext bc, int index) {
                      var tarefa = _tarefas[index];
                      return Dismissible(
                        onDismissed: (DismissDirection direction) async {
                          tarefaRepository.excluir(tarefa);
                          obterTarefas();
                        },
                        key: Key(tarefa.descricao),
                        child: ListTile(
                          title: Text(tarefa.descricao),
                          trailing: Switch(
                            onChanged: (bool value) async {
                              tarefa.concluida = value;
                              tarefaRepository.alterar(tarefa);
                              obterTarefas();
                            },
                            value: tarefa.concluida,
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
