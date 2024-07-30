import 'package:flutter/material.dart';
import 'package:trilhaapp/model/tarefa_model_sqlite.dart';
import 'package:trilhaapp/repositories/sqlite/tarefa_sqlite_repository.dart';

class TarefaSqlitePage extends StatefulWidget {
  const TarefaSqlitePage({super.key});

  @override
  State<TarefaSqlitePage> createState() => _TarefaSqlitePageState();
}

class _TarefaSqlitePageState extends State<TarefaSqlitePage> {
  TarefaSqliteRepository tarefaRepository = TarefaSqliteRepository();

  var _tarefas = const <TarefaModelSqlite>[];
  TextEditingController descricaoController = TextEditingController();
  var apenasNaoConcluidas = false;

  void initState() {
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async {
    _tarefas = await tarefaRepository.obterDados();

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
                              await tarefaRepository.salvar(TarefaModelSqlite(
                                  0, descricaoController.text, false));
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
                          await tarefaRepository.deletar(tarefa.getId());
                          obterTarefas();
                        },
                        key: Key(tarefa.getDescricao()),
                        child: ListTile(
                          title: Text(tarefa.getDescricao()),
                          trailing: Switch(
                            onChanged: (bool value) async {
                              tarefa.setFinalizada(value);
                              tarefaRepository.atualizar(tarefa);
                              obterTarefas();
                            },
                            value: tarefa.getFinalizada(),
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
