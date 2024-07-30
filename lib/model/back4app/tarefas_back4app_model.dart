class TarefasBack4appModel {
  List<TarefasBack4app>? tarefas;

  TarefasBack4appModel({this.tarefas});

  TarefasBack4appModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      tarefas = <TarefasBack4app>[];
      json['results'].forEach((v) {
        tarefas!.add(TarefasBack4app.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tarefas != null) {
      data['results'] = tarefas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TarefasBack4app {
  String? objectId;
  String? descricao;
  bool? status;
  String? createdAt;
  String? updatedAt;

  TarefasBack4app(
      {this.objectId,
      this.descricao,
      this.status,
      this.createdAt,
      this.updatedAt});

  TarefasBack4app.criar({
    this.descricao,
    this.status,
  });

  TarefasBack4app.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    descricao = json['descricao'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = objectId;
    data['descricao'] = descricao;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }

  Map<String, dynamic> toJsonEndpoint() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['descricao'] = descricao;
    data['status'] = status;
    return data;
  }
}
