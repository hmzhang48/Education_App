import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'state.dart';

class Result extends HookConsumerWidget {
  final String id;
  final int score;

  const Result({
    super.key,
    required this.id,
    required this.score,
  });

  @override
  Widget build(context, ref) {
    final future = useMemoized(
      () => ref
          .read(PathNotifierProvider().notifier)
          .updatePath(id, {'learning': true}),
    );
    final snapshot = useFuture(future);
    if (snapshot.connectionState == ConnectionState.done) {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Text(
                'Your knowledge level is...',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: 20.0),
              ),
            ),
            ClipOval(
              child: Container(
                width: 100,
                height: 100,
                color: Theme.of(context).colorScheme.primaryContainer,
                alignment: Alignment.center,
                child: Text(
                  switch (score) {
                    < 10 => '1',
                    < 20 => '2',
                    _ => '10',
                  },
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 50.0),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      'Your personalized learning path is ready.\nLet\'s start learning!',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 16.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            TextButton(
              child: const Text('Next'),
              onPressed: () => context.goNamed('Progress'),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(body: const Center(child: CircularProgressIndicator()));
    }
  }
}
