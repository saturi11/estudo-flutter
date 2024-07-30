import 'package:hive/hive.dart';
import 'package:trilhaapp/model/config_model.dart';

class ConfigRepository {
  static late Box _box;
  ConfigRepository._load();
  static Future<ConfigRepository> load() async {
    if (Hive.isBoxOpen('config')) {
      _box = Hive.box('config');
    } else {
      _box = await Hive.openBox('config');
    }
    return ConfigRepository._load();
  }

  void salvar(ConfigModel configModel) {
    _box.put('config', {
      'nome': configModel.nome,
      'altura': configModel.altura,
      'notificacoes': configModel.notificacoes,
      'modoEscuro': configModel.modoEscuro,
    });
  }

  ConfigModel carregar() {
    var config = _box.get('config');
    if (config == null) {
      return ConfigModel.vazio();
    }
    return ConfigModel(
      _box.get('config')['nome'],
      _box.get('config')['altura'],
      _box.get('config')['notificacoes'],
      _box.get('config')['modoEscuro'],
    );
  }
}
