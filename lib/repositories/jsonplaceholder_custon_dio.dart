import 'package:dio/dio.dart';

class JsonplaceholderCustonDio {
  var _dio = Dio();

  Dio get dio => _dio;

  JsonplaceholderCustonDio() {
    _dio.options.baseUrl = "https://jsonplaceholder.typicode.com";
  }
}
