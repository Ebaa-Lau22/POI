import 'package:poi/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../entities/post.dart';

abstract class PostsRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, Unit>> addPost(Post post);
  Future<Either<Failure, Unit>> deletePost(int id);
  Future<Either<Failure, Unit>> updatePost(Post post);
}