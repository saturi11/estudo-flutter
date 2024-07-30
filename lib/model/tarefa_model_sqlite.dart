class TarefaModelSqlite {
  int _id = 0;

  String _descricao = "";

  bool _concluido = false;

  TarefaModelSqlite(this._id, this._descricao, this._concluido);

  int getId() {
    return _id;
  }

  String getDescricao() {
    return _descricao;
  }

  bool getFinalizada() {
    return _concluido;
  }

  void setdescricao(String descricao) {
    _descricao = descricao;
  }

  void setFinalizada(bool finalizada) {
    _concluido = finalizada;
  }

  void setId(int id) {
    _id = id;
  }
}
