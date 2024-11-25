import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'state.dart';
import 'post_list.dart';

class Profile extends HookConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(context, ref) {
    final tabController = useTabController(initialLength: 2);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 25,
          ),
          child: Row(
            children: [
              Image.asset(
                'assets/avatar.png',
                width: 50,
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Avatar',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 20.0,
                          ),
                    ),
                    Text(
                      'Student',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 12.0,
                          ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        TabBar(
          controller: tabController,
          tabs: const [
            Tab(
              text: 'Badges',
              icon: Icon(Icons.emoji_events_outlined),
            ),
            Tab(
              text: 'Posts',
              icon: Icon(Icons.article_outlined),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/badge.png',
                      width: 100,
                      height: 100,
                    )
                  ],
                ),
              ),
              ref.watch(PostNotifierProvider(user: 'avatar')).when(
                    data: (value) => PostList(posts: value),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stack) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Please Retry'),
                          duration: const Duration(milliseconds: 1500),
                          width: MediaQuery.of(context).size.width / 4 * 3,
                          padding: const EdgeInsets.all(8.0),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                      return const SizedBox.shrink();
                    },
                  ),
            ],
          ),
        ),
      ],
    );
  }
}
