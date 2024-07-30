import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:dio/dio.dart';
import 'package:trilhaapp/model/characters_model.dart';

class MarvelApiRepository {
  final Dio _dio = Dio();

  MarvelApiRepository() {
    _dio.options.baseUrl = "https://gateway.marvel.com/v1/public";
  }

  Future<CharacterModel> getCharacters(int offset) async {
    var ts = DateTime.now().microsecondsSinceEpoch.toString();
    var publickey = "970aa67bfd28adcc3c60d513c3324c28";
    var privatkey = "e7b04b59d2d8361a2e9dbbc5345ca10e3b49e297";
    var hash = _generateMd5(ts + privatkey + publickey);
    _dio.options.queryParameters = {
      "offset": offset.toString(),
      "ts": ts,
      "apikey": publickey,
      "hash": hash,
    };

    var res = await _dio.get("/characters");

    var characterModel = CharacterModel.fromJson(res.data);
    return characterModel;
  }

  String _generateMd5(String data) {
    var content = const Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }
}
