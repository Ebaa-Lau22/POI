import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/post.dart';
import '../repositories/posts_repository.dart';

class UpdatePostUseCase{
  final PostsRepository repository;

  UpdatePostUseCase({required this.repository});

  Future<Either<Failure, Unit>> call({
    required Post post
  }) async{
    return await repository.updatePost(post);
  }
}