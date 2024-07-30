import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:trilhaapp/model/dados_cadastrais.dart';
import 'package:trilhaapp/model/tarefa_hive_model.dart';
import 'package:trilhaapp/pages/my_app.dart';
import 'package:trilhaapp/repositories/sqlite/database.dart' as Database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("Diretório atual: ${Directory.current.path}");
  final envFilePath = ".env";
  final file = File(envFilePath);

  if (await file.exists()) {
    try {
      await dotenv.load(fileName: envFilePath);
      print("Arquivo .env carregado com sucesso");
    } catch (e, stacktrace) {
      print("Erro ao carregar o arquivo .env: $e");
      print("Stacktrace: $stacktrace");
    }
  } else {
    print("Arquivo .env não encontrado no caminho $envFilePath");
  }

  var documentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(documentDirectory.path);
  Hive.registerAdapter(DadosCadastraisAdapter());
  Hive.registerAdapter(TarefaHiveModelAdapter());

  await Database.DatabaseHelper().initBanco();
  await Database.DatabaseHelper().addConcluidoColumn();

  runApp(const MyWidget());
}
