import 'package:hive/hive.dart';
import 'package:trilhaapp/model/dados_cadastrais.dart';

class DadosCadastraisRepository {
  static late Box _box;
  DadosCadastraisRepository._load();
  static Future<DadosCadastraisRepository> loadRepository() async {
    if (Hive.isBoxOpen('DadosCadastraisModel')) {
      _box = Hive.box('DadosCadastraisModel');
    } else {
      _box = await Hive.openBox('DadosCadastraisModel');
    }
    return DadosCadastraisRepository._load();
  }

  void salvar(DadosCadastrais dadosCadastraisModel) {
    _box.put('DadosCadastraisModel', {
      'nome': dadosCadastraisModel.nome,
      'dataNascimento': dadosCadastraisModel.dataNascimento?.toIso8601String(),
      'nivelExperiencia': dadosCadastraisModel.nivelExperiencia,
      'linguagens': dadosCadastraisModel.linguagens,
      'tempoExperiencia': dadosCadastraisModel.tempoExperiencia?.toString(),
      'salario': dadosCadastraisModel.salario?.toString(),
    });
  }

  DadosCadastrais load() {
    var dadosCadastraisModel = _box.get('DadosCadastraisModel');
    if (dadosCadastraisModel is Map) {
      var dadosCadastrais = DadosCadastrais();
      dadosCadastrais.nome = dadosCadastraisModel['nome'] ?? '';
      dadosCadastrais.dataNascimento =
          dadosCadastraisModel['dataNascimento'] != null
              ? DateTime.parse(dadosCadastraisModel['dataNascimento'])
              : null;
      dadosCadastrais.nivelExperiencia =
          dadosCadastraisModel['nivelExperiencia'] ?? '';
      dadosCadastrais.linguagens = dadosCadastraisModel['linguagens'] ?? '';
      dadosCadastrais.tempoExperiencia =
          dadosCadastraisModel['tempoExperiencia'] != null
              ? int.parse(dadosCadastraisModel['tempoExperiencia'])
              : null;
      dadosCadastrais.salario = dadosCadastraisModel['salario'] != null
          ? double.parse(dadosCadastraisModel['salario'])
          : null;
      return dadosCadastrais;
    } else if (dadosCadastraisModel == null) {
      return DadosCadastrais();
    } else {
      return dadosCadastraisModel as DadosCadastrais;
    }
  }
}
