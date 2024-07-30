class ConfigModel {
  String _nome = '';
  double _altura = 0;
  bool _notificacoes = false;
  bool _modoEscuro = false;

  ConfigModel.vazio() {
    _nome = '';
    _altura = 0;
    _notificacoes = false;
    _modoEscuro = false;
  }

  ConfigModel(this._nome, this._altura, this._notificacoes, this._modoEscuro);

  String get nome => _nome;
  double get altura => _altura;
  bool get notificacoes => _notificacoes;
  bool get modoEscuro => _modoEscuro;

  set nome(String nome) {
    _nome = nome;
  }

  set altura(double altura) {
    _altura = altura;
  }

  set notificacoes(bool notificacoes) {
    _notificacoes = notificacoes;
  }

  set modoEscuro(bool modoEscuro) {
    _modoEscuro = modoEscuro;
  }
}
