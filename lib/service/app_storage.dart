import 'package:shared_preferences/shared_preferences.dart';

enum StorageKey {
  nome,
  dataNascimento,
  nivelConhecimento,
  linguagens,
  salario,
  tempoExperiencia,
  altura,
  notificacoes,
  modoEscuro,
}

class AppStorage {
  Future<void> setString(String key, String value) async {
    var storage = await SharedPreferences.getInstance();
    storage.setString(key, value);
  }

  Future<String?> getString(String key) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getString(key);
  }

  Future<void> setNome(String nome) =>
      setString(StorageKey.nome.toString(), nome);
  Future<String?> getNome() => getString(StorageKey.nome.toString());

  Future<void> setDataNascimento(String dataNascimento) =>
      setString(StorageKey.dataNascimento.toString(), dataNascimento);
  Future<String?> getDataNascimento() =>
      getString(StorageKey.dataNascimento.toString());

  Future<void> setNivelConhecimento(String nivelConhecimento) =>
      setString(StorageKey.nivelConhecimento.toString(), nivelConhecimento);
  Future<String?> getNivelConhecimento() =>
      getString(StorageKey.nivelConhecimento.toString());

  Future<void> setLinguagens(List<String> linguagens) async {
    var storage = await SharedPreferences.getInstance();
    storage.setStringList(StorageKey.linguagens.toString(), linguagens);
  }

  Future<List<String>?> getLinguagens() async {
    var storage = await SharedPreferences.getInstance();
    return storage.getStringList(StorageKey.linguagens.toString());
  }

  Future<void> setSalario(double salario) async {
    var storage = await SharedPreferences.getInstance();
    storage.setDouble(StorageKey.salario.toString(), salario);
  }

  Future<double?> getSalario() async {
    var storage = await SharedPreferences.getInstance();
    return storage.getDouble(StorageKey.salario.toString());
  }

  Future<void> setTempoExperiencia(int tempoExperiencia) async {
    var storage = await SharedPreferences.getInstance();
    storage.setInt(StorageKey.tempoExperiencia.toString(), tempoExperiencia);
  }

  Future<int?> getTempoExperiencia() async {
    var storage = await SharedPreferences.getInstance();
    return storage.getInt(StorageKey.tempoExperiencia.toString());
  }

  Future<void> setAltura(double altura) async {
    var storage = await SharedPreferences.getInstance();
    storage.setDouble(StorageKey.altura.toString(), altura);
  }

  Future<double?> getAltura() async {
    var storage = await SharedPreferences.getInstance();
    return storage.getDouble(StorageKey.altura.toString());
  }

  Future<void> setNotificacoes(bool notificacoes) async {
    var storage = await SharedPreferences.getInstance();
    storage.setBool(StorageKey.notificacoes.toString(), notificacoes);
  }

  Future<bool?> getNotificacoes() async {
    var storage = await SharedPreferences.getInstance();
    return storage.getBool(StorageKey.notificacoes.toString());
  }

  Future<void> setModoEscuro(bool modoEscuro) async {
    var storage = await SharedPreferences.getInstance();
    storage.setBool(StorageKey.modoEscuro.toString(), modoEscuro);
  }

  Future<bool?> getModoEscuro() async {
    var storage = await SharedPreferences.getInstance();
    return storage.getBool(StorageKey.modoEscuro.toString());
  }
}
