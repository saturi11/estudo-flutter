import 'package:trilhaapp/model/comments_model.dart';

abstract class CommentsRepositoryInterface {
  Future<List<CommentsModel>> getComments(int postId);
}
