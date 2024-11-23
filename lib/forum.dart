import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'state.dart';
import 'group_list.dart';

class Forum extends HookConsumerWidget {
  const Forum({super.key});

  @override
  Widget build(context, ref) {
    return ref.watch(PathNotifierProvider(true)).when(
          data: (value) => GroupList(groups: value),
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
