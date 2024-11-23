import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'state.dart';

class CourseList extends ConsumerWidget {
  final String id;

  const CourseList({
    super.key,
    required this.id,
  });

  @override
  Widget build(context, ref) {
    final data = ref.watch(CourseProvider(id));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          switch (data) {
            AsyncData(:final value) => value[0].path,
            AsyncError() => 'Error',
            _ => '',
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            tooltip: 'more',
            onPressed: () {},
          ),
        ],
      ),
      body: data.when(
        data: (value) => ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          itemCount: value.length + 1,
          itemBuilder: (context, index) {
            if (index == value.length) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FilledButton(
                    child: const Text('Start'),
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Before you start...'),
                        content: const Text(
                            'You need to finish a test to evaluate your knowledge level about this subject so that we can provide a personalized learning path for you.'),
                        actions: [
                          TextButton(
                            onPressed: () => context.pop(),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              context.pop();
                              context.goNamed(
                                'Test',
                                pathParameters: {'id': id},
                              );
                            },
                            child: const Text('Continue'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return ListTile(
              leading: CircleAvatar(
                child: Text((index + 1).toString()),
              ),
              title: Text(value[index].name),
              subtitle: Text(value[index].description),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
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
          return null;
        },
      ),
    );
  }
}
