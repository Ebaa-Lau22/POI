import '../../domain/entities/post.dart';

abstract class PostsStates {}

class PostsInitialState extends PostsStates {}

class PostsLoadingState extends PostsStates {}

class PostsGetPostsSuccessState extends PostsStates {}

class PostsGetPostsErrorState extends PostsStates {
  String errorMessage;

  PostsGetPostsErrorState({required this.errorMessage});
}

class AddUpdateDeletePostLoadingState extends PostsStates {}

class AddUpdateDeletePostSuccessState extends PostsStates {
  String successMessage;

  AddUpdateDeletePostSuccessState({required this.successMessage});
}

class AddUpdateDeletePostErrorState extends PostsStates {
  String errorMessage;

  AddUpdateDeletePostErrorState({required this.errorMessage});
}
