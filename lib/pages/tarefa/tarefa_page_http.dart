import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trilhaapp/model/back4app/tarefas_back4app_model.dart';
import 'package:trilhaapp/repositories/back4app/tarefas_back4app_repository.dart';

class TarefaHttpPage extends StatefulWidget {
  const TarefaHttpPage({super.key});

  @override
  State<TarefaHttpPage> createState() => _TarefaHttpPageState();
}

class _TarefaHttpPageState extends State<TarefaHttpPage> {
  TarefasBack4AppRepository tarefaRepository = TarefasBack4AppRepository();
  var _tarefasBack4app = TarefasBack4appModel();

  TextEditingController descricaoController = TextEditingController();
  var apenasNaoConcluidas = false;

  @override
  void initState() {
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async {
    _tarefasBack4app = await tarefaRepository.obterTarefas(apenasNaoConcluidas);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas Com Back4App'),
        backgroundColor: Colors.teal.shade700,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          descricaoController.text = '';
          showDialog(
            context: context,
            builder: (BuildContext bc) {
              return AlertDialog(
                title: const Text('Adicionar Tarefa'),
                content: TextField(
                  controller: descricaoController,
                  decoration: InputDecoration(
                    hintText: 'Descrição da tarefa',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.teal.shade50,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await tarefaRepository
                          .adicionarTarefa(TarefasBack4app.criar(
                        descricao: descricaoController.text,
                        status: false,
                      ));
                      Navigator.pop(context);
                      obterTarefas();
                    },
                    child: const Text('Salvar'),
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: Colors.teal.shade700,
        child: const Icon(Icons.add),
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tarefas não concluídas",
                    style: GoogleFonts.roboto(
                        fontSize: 18, color: Colors.teal.shade700),
                  ),
                  Switch(
                    value: apenasNaoConcluidas,
                    onChanged: (bool value) {
                      setState(() {
                        apenasNaoConcluidas = value;
                      });
                      obterTarefas();
                    },
                    activeColor: Colors.teal.shade700,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tarefasBack4app.tarefas?.length ?? 0,
                itemBuilder: (BuildContext bc, int index) {
                  var tarefa = _tarefasBack4app.tarefas![index];
                  return Dismissible(
                    key: Key(tarefa.descricao ?? ''),
                    onDismissed: (DismissDirection direction) async {
                      await tarefaRepository
                          .removerTarefa(tarefa.objectId ?? '');
                      obterTarefas();
                    },
                    background: Container(color: Colors.red),
                    child: ListTile(
                      title: Text(
                        tarefa.descricao ?? '',
                        style: GoogleFonts.roboto(fontSize: 16),
                      ),
                      trailing: Switch(
                        value: tarefa.status ?? false,
                        onChanged: (bool value) async {
                          setState(() {
                            tarefa.status = value;
                          });
                          await tarefaRepository.atualizarTarefa(tarefa);
                          obterTarefas();
                        },
                        activeColor: Colors.teal.shade700,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
