import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'state.dart';

class Setting extends ConsumerWidget {
  const Setting({super.key});

  @override
  Widget build(context, ref) {
    return Center(
      child: TextButton(
        onPressed: () {
          ref.read(authProvider).signOut();
          context.goNamed('Welcome');
        },
        child: Text(
          'Sign Out',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.error,
                fontSize: 20.0,
              ),
        ),
      ),
    );
  }
}
