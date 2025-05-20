import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poi/core/constants/constants.dart';
import 'package:poi/core/function/error_message.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/post.dart';
import '../../domain/usecases/add_post.dart';
import '../../domain/usecases/delete_post.dart';
import '../../domain/usecases/get_all_posts.dart';
import '../../domain/usecases/update_post.dart';
import 'posts_states.dart';

class PostsCubit extends Cubit<PostsStates> {
  PostsCubit({
    required this.getAllPostsUseCase,
    required this.addPostUseCase,
    required this.updatePostUseCase,
    required this.deletePostUseCase,
  }) : super(PostsInitialState());
  static PostsCubit get(context) => BlocProvider.of(context);

  List<Post> posts = [];
  final GetAllPostsUseCase getAllPostsUseCase;
  void getAllPosts() async {
    emit(PostsLoadingState());
    final failureOrPosts = await getAllPostsUseCase();
    failureOrPosts.fold(
      (failure) {
        emit(PostsGetPostsErrorState(
            errorMessage: mapFailureToMessage(failure)));
      },
      (postsList) {
        posts = postsList;
        emit(PostsGetPostsSuccessState());
      },
    );
  }

  final AddPostUseCase addPostUseCase;
  void addPost({required Post post}) async {
    emit(AddUpdateDeletePostLoadingState());
    final unitOrFailure = await addPostUseCase(post: post);
    emit(_failureOrSuccessMessage(unitOrFailure, ADD_POST_SUCCESS_MESSAGE));
  }

  final UpdatePostUseCase updatePostUseCase;
  void updatePost({required Post post}) async {
    emit(AddUpdateDeletePostLoadingState());
    final unitOrFailure = await updatePostUseCase(post: post);
    emit(_failureOrSuccessMessage(unitOrFailure, Update_POST_SUCCESS_MESSAGE));
  }

  final DeletePostUseCase deletePostUseCase;
  void deletePost({required int postId}) async {
    emit(AddUpdateDeletePostLoadingState());
    final unitOrFailure = await deletePostUseCase(id: postId);
    emit(_failureOrSuccessMessage(unitOrFailure, Delete_POST_SUCCESS_MESSAGE));
  }

  PostsStates _failureOrSuccessMessage (
      Either<Failure, Unit> either,
      String message
      ) {
    return either.fold(
          (failure) {
        return AddUpdateDeletePostErrorState(
            errorMessage: mapFailureToMessage(failure));
      },
          (_) {
        getAllPosts();
        return AddUpdateDeletePostSuccessState(
            successMessage: message,
        );
      },
    );

  }
}

