import 'package:flutter/material.dart';

class Tarefa {
  final String _id = UniqueKey().toString();
  String _descricao = "";
  bool _finalizada = false;

  Tarefa(this._descricao, this._finalizada);

  String getId() {
    return _id;
  }

  String getDescricao() {
    return _descricao;
  }

  bool getFinalizada() {
    return _finalizada;
  }

  void setdescricao(String descricao) {
    _descricao = descricao;
  }

  void setFinalizada(bool finalizada) {
    _finalizada = finalizada;
  }
}
