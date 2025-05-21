import 'package:flutter/material.dart';
import 'package:poi/core/theme/app_colors.dart';

import '../../domain/entities/post.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> posts;
  const PostListWidget({required this.posts, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
      ),
      child: ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(posts[index].id.toString()),
            title: Text(
              posts[index].title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.darkBlue),
            ),
            subtitle: Text(
              posts[index].body,
              style: TextStyle(color: AppColors.mainDark, fontSize: 16),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          );
        },
        separatorBuilder: (context, index) => const Divider(thickness: 1,),
        itemCount: posts.length,
      ),
    );
  }
}
