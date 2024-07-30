import 'dart:async';

import 'package:trilhaapp/model/comments_model.dart';
import 'package:trilhaapp/repositories/comments/interface/comments_interface.dart';
import 'package:trilhaapp/repositories/jsonplaceholder_custon_dio.dart';

class CommentsDioRepository implements CommentsRepositoryInterface {
  @override
  Future<List<CommentsModel>> getComments(int id) async {
    var jsonCustonDio = JsonplaceholderCustonDio();
    var res = await jsonCustonDio.dio.get("/posts/$id/comments");
    if (res.statusCode == 200) {
      return (res.data as List)
          .map((post) => CommentsModel.fromJson(post))
          .toList();
    } else {
      return [];
    }
  }
}
