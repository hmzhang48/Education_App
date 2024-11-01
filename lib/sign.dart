import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'data_provider.dart';
import 'data.dart';

class Sign extends StatefulWidget {
  final bool create;

  const Sign({
    super.key,
    required this.create,
  });

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(context) {
    var auth = DataProvider.of<DataStore>(context).auth;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.create ? 'Sign up' : 'Sign in'),
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
                  try {
                    widget.create
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
                child: Text(widget.create ? 'Sign up' : 'Sign in'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
