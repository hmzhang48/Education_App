import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'state.dart';
import 'question_list.dart';

class Test extends ConsumerWidget {
  final String id;

  const Test({
    super.key,
    required this.id,
  });

  @override
  Widget build(context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          switch (ref.watch(QuestionProvider(id))) {
            AsyncData(:final value) => '${value[0].path} Test',
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
      body: ref.watch(QuestionProvider(id)).when(
            data: (value) => QuestionList(
              questions: value,
              id: id,
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
