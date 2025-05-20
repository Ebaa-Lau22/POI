import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poi/core/components/loading_widget.dart';
import 'package:poi/core/theme/app_colors.dart';
import 'package:poi/core/theme/app_theme.dart';
import 'package:poi/features/posts/presentation/widgets/message_display_widget.dart';
import '../bloc/posts_cubit.dart';
import '../bloc/posts_states.dart';
import '../widgets/post_list_widget.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Posts",
          style: TextStyle(
            color: whiteColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: lightTheme.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocConsumer<PostsCubit, PostsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = PostsCubit.get(context);
            if (state is PostsLoadingState) {
              return const Center(child: LoadingWidget());
            } else if (state is PostsGetPostsSuccessState) {
              return RefreshIndicator(
                child: PostListWidget(
                  posts: cubit.posts,
                ),
                onRefresh: () => _onRefresh(context),
              );
            } else if (state is PostsGetPostsErrorState) {
              return MessageDisplayWidget(message: state.errorMessage);
            } else {
              return const Center(child: LoadingWidget());
            }
          },
        ),
      ),
      floatingActionButton: _buildFloatingBtn(),
    );
  }

  Widget _buildFloatingBtn() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: lightRedColor,
      child: const Icon(
        Icons.add,
        size: 24,
        color: whiteColor,
      ),
    );
  }
  Future<void> _onRefresh(BuildContext context) async{
    BlocProvider.of<PostsCubit>(context).getAllPosts();
  }

}
