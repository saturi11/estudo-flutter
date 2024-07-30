import 'dart:async';

import 'package:dio/dio.dart';
import 'package:trilhaapp/model/post_model.dart';
import 'package:trilhaapp/repositories/posts/interface/posts_interface.dart';

class PostsDioRepository implements PostsRepositoryInterface {
  @override
  Future<List<PostModel>> getPosts() async {
    var dio = Dio();
    var res = await dio.get("https://jsonplaceholder.typicode.com/posts");
    if (res.statusCode == 200) {
      return (res.data as List)
          .map((post) => PostModel.fromJson(post))
          .toList();
    } else {
      return [];
    }
  }
}
