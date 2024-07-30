import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trilhaapp/model/comments_model.dart';
import 'package:trilhaapp/repositories/comments/interface/comments_interface.dart';

class CommentsHttpRepository implements CommentsRepositoryInterface {
  @override
  Future<List<CommentsModel>> getComments(int id) async {
    var res = await http
        .get(Uri.parse(
            "https://jsonplaceholder.typicode.com/posts/$id/comments"))
        .catchError((error) {
      print(error);
    });
    if (res.statusCode == 200) {
      var posts = jsonDecode(res.body);
      return (posts as List)
          .map((post) => CommentsModel.fromJson(post))
          .toList();
    } else {
      return [];
    }
  }
}
