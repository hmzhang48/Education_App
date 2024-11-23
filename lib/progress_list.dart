import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'state.dart';
import 'card_item.dart';

class ProgressList extends ConsumerWidget {
  const ProgressList({super.key});

  @override
  Widget build(context, ref) {
    return ref.watch(PathNotifierProvider(true)).when(
          data: (value) => ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            itemCount: value.length,
            itemBuilder: (context, index) => CardItem(
              header: value[index].name,
              content:
                  'Time: ${value[index].learningTime ~/ 60} Hours ${value[index].learningTime % 60} Minutes\nProgress: ${(value[index].learningTime / value[index].totalTime * 100).ceil()}%',
              image: value[index].image,
              onTap: () => context.goNamed(
                'Lecture',
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
        );
  }
}
