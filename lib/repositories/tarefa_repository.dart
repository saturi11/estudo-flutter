import 'package:trilhaapp/model/tarefa.dart';

class TarefaRepository {
  final List<Tarefa> _tarefas = [];

  Future<void> addTarefa(Tarefa tarefa) async {
    await Future.delayed(const Duration(microseconds: 100));
    _tarefas.add(tarefa);
  }

  Future<void> removeTarefa(String id) async {
    await Future.delayed(const Duration(microseconds: 100));
    _tarefas.removeWhere((element) => element.getId() == id);
  }

  Future<void> updateTarefa(String id, bool finalizada) async {
    await Future.delayed(const Duration(microseconds: 100));
    _tarefas
        .firstWhere((tarefa) => tarefa.getId() == id)
        .setFinalizada(finalizada);
  }

  Future<List<Tarefa>> getTarefas() async {
    await Future.delayed(const Duration(microseconds: 100));
    return _tarefas;
  }

  Future<List<Tarefa>> getTarefasNaoConcluidas() async {
    await Future.delayed(const Duration(microseconds: 100));
    return _tarefas.where((tarefa) => !tarefa.getFinalizada()).toList();
  }
}
