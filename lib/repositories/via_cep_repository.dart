import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trilhaapp/model/via_cep_model.dart';

class ViaCepRepository {
  Future<ViaCepModel> obterEndereco(String cep) async {
    var res = await http
        .get(Uri.parse("https://viacep.com.br/ws/${cep}/json/"))
        .catchError((error) {
      print(error);
    });
    if (res.statusCode != 200) {
      return ViaCepModel();
    } else {
      var resJson = jsonDecode(res.body);
      return ViaCepModel.fromJson(resJson);
    }
  }
}
