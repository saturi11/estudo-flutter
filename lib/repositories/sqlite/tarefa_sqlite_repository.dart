import 'package:trilhaapp/model/tarefa_model_sqlite.dart';
import 'package:trilhaapp/repositories/sqlite/database.dart';

class TarefaSqliteRepository {
  Future<List<TarefaModelSqlite>> obterDados() async {
    List<TarefaModelSqlite> tarefas = [];
    var db = await DatabaseHelper().obterDatabase();
    var result =
        await db.rawQuery('SELECT id, descricao, concluido FROM tarefas');
    for (var element in result) {
      tarefas.add(TarefaModelSqlite(
          int.parse(element["id"].toString()),
          element["descricao"].toString(),
          element["concluido"] == 1 ? true : false));
    }
    return tarefas;
  }

  Future<void> salvar(TarefaModelSqlite tarefa) async {
    var db = await DatabaseHelper().obterDatabase();
    await db.rawInsert('INSERT INTO tarefas(descricao, concluido) VALUES(?, ?)',
        [tarefa.getDescricao(), tarefa.getFinalizada() ? 1 : 0]);
  }

  Future<void> atualizar(TarefaModelSqlite tarefa) async {
    var db = await DatabaseHelper().obterDatabase();
    await db.rawUpdate(
        'UPDATE tarefas SET descricao = ?, concluido = ? WHERE id = ?', [
      tarefa.getDescricao(),
      tarefa.getFinalizada() ? 1 : 0,
      tarefa.getId()
    ]);
  }

  Future<void> deletar(int id) async {
    var db = await DatabaseHelper().obterDatabase();
    await db.rawDelete('DELETE FROM tarefas WHERE id = ?', [id]);
  }
}
