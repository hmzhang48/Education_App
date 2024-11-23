import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'state.dart';
import 'card_item.dart';

class PathList extends ConsumerWidget {
  const PathList({super.key});

  @override
  Widget build(context, ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10,
          ),
          child: Text(
            'What do you want to learn?',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20.0,
                ),
          ),
        ),
        Expanded(
          child: ref.watch(PathNotifierProvider(false)).when(
                data: (value) => ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  itemCount: value.length,
                  itemBuilder: (context, index) => CardItem(
                    header: value[index].name,
                    content: value[index].description,
                    image: value[index].image,
                    onTap: () => context.goNamed(
                      'Course',
                      pathParameters: {'id': value[index].id!},
                    ),
                  ),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
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
        )
      ],
    );
  }
}
