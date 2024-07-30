import 'package:hive/hive.dart';
import 'package:trilhaapp/model/tarefa_hive_model.dart';

class TarefeHiveRepository {
  static late Box _box;

  TarefeHiveRepository._criar();

  static Future<TarefeHiveRepository> carregar() async {
    if (Hive.isBoxOpen('tarefas')) {
      _box = Hive.box('tarefas');
    } else {
      _box = await Hive.openBox('tarefas');
    }

    return TarefeHiveRepository._criar();
  }

  salvar(TarefaHiveModel tarefaHiveModel) {
    _box.add(tarefaHiveModel);
  }

  alterar(TarefaHiveModel tarefaHiveModel) {
    tarefaHiveModel.save();
  }

  excluir(TarefaHiveModel tarefaHiveModel) {
    tarefaHiveModel.delete();
  }

  List<TarefaHiveModel> obterDados(bool apenasNaoConcluidas) {
    if (apenasNaoConcluidas) {
      return _box.values
          .where((element) => (element as TarefaHiveModel).concluida == false)
          .cast<TarefaHiveModel>()
          .toList();
    }
    return _box.values.cast<TarefaHiveModel>().toList();
  }
}
