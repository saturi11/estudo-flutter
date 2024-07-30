import 'package:hive/hive.dart';

part 'dados_cadastrais.g.dart';

@HiveType(typeId: 0)
class DadosCadastrais extends HiveObject {
  @HiveField(0)
  String? nome;

  @HiveField(1)
  DateTime? dataNascimento;

  @HiveField(2)
  String? nivelExperiencia;

  @HiveField(3)
  List<String> linguagens = [];

  @HiveField(4)
  int? tempoExperiencia;

  @HiveField(5)
  double? salario;

  DadosCadastrais();

  DadosCadastrais.vazio() {
    nome = '';
    dataNascimento = DateTime.now();
    nivelExperiencia = '';
    linguagens = [];
    tempoExperiencia = 0;
    salario = 0.0;
  }
}
