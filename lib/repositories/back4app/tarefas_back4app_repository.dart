import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:trilhaapp/model/back4app/tarefas_back4app_model.dart';

class TarefasBack4AppRepository {
  var _dio = Dio();
  TarefasBack4AppRepository() {
    _dio = Dio();
    _dio.options.headers["X-Parse-Application-Id"] =
        dotenv.get("BACK4APPAPLICATIONID");
    _dio.options.headers["X-Parse-REST-API-Key"] =
        dotenv.get("BACK4APPRESTAPIKEY");

    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = "https://parseapi.back4app.com/classes";
  }

  Future<TarefasBack4appModel> obterTarefas(bool naoConcluidas) async {
    var url = "/Tarefas";
    if (naoConcluidas) {
      url += "?where={\"status\":false}";
    }
    var response = await _dio.get(url);
    return TarefasBack4appModel.fromJson(response.data);
  }

  Future<void> adicionarTarefa(TarefasBack4app tarefa) async {
    var url = "/Tarefas";
    await _dio.post(url, data: tarefa.toJsonEndpoint());
  }

  Future<void> atualizarTarefa(TarefasBack4app tarefa) async {
    var url = "/Tarefas/${tarefa.objectId}";
    await _dio.put(url, data: tarefa.toJsonEndpoint());
  }

  Future<void> removerTarefa(String id) async {
    var url = "/Tarefas/$id";
    await _dio.delete(url);
  }
}
