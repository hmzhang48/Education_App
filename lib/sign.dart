import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'state.dart';

class Sign extends HookConsumerWidget {
  final bool create;

  const Sign({
    super.key,
    required this.create,
  });

  @override
  Widget build(context, ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(create ? 'Sign up' : 'Sign in'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            tooltip: 'More',
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Email'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Password'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: FilledButton(
                onPressed: () async {
                  final auth = ref.read(authProvider);
                  try {
                    create
                        ? await auth.createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          )
                        : await auth.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                    if (context.mounted) {
                      context.goNamed('Resource');
                    }
                  } on FirebaseAuthException catch (e) {
                    if (context.mounted) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          icon: const Icon(
                            Icons.warning_outlined,
                            size: 35,
                          ),
                          title: Text(
                            e.code,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                  }
                },
                child: Text(create ? 'Sign up' : 'Sign in'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
