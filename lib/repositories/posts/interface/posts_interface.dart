import 'package:trilhaapp/model/post_model.dart';

abstract class PostsRepositoryInterface {
  Future<List<PostModel>> getPosts();
}
