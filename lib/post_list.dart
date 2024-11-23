import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'model.dart';
import 'card_item.dart';

class PostList extends StatelessWidget {
  const PostList({
    super.key,
    required this.posts,
  });

  final List<PostItem> posts;

  @override
  Widget build(context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      itemCount: posts.length,
      itemBuilder: (context, index) => CardItem(
        user: posts[index].user,
        timestamp: posts[index].timestamp,
        header: posts[index].title,
        content: posts[index].content,
        image: posts[index].image.isEmpty
            ? 'placeholder.png'
            : posts[index].image[0],
        like: posts[index].like,
        bookmark: posts[index].bookmark,
        comments: posts[index].comments.length,
        onTap: () => context.goNamed(
          'Post',
          extra: posts[index],
        ),
      ),
    );
  }
}
