import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trilhaapp/model/post_model.dart';
import 'package:trilhaapp/repositories/posts/interface/posts_interface.dart';

class PostsHttpRepository implements PostsRepositoryInterface {
  @override
  Future<List<PostModel>> getPosts() async {
    var res = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/posts"))
        .catchError((error) {
      print(error);
    });
    if (res.statusCode == 200) {
      var posts = jsonDecode(res.body);
      return (posts as List).map((post) => PostModel.fromJson(post)).toList();
    } else {
      return [];
    }
  }
}
