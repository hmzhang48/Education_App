import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'firebase_options.dart';
import 'state.dart';
import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kDebugMode) {
    await initState();
  }
  runApp(
    ProviderScope(
      child: const MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(context, ref) {
    return MaterialApp.router(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff028090)),
      ),
      routerConfig: GoRouter(
        navigatorKey: rootNavigatorKey,
        initialLocation: '/resource',
        redirect: (context, state) {
          if (ref.read(authProvider).currentUser == null &&
              state.fullPath!.split('/')[1] != 'welcome') {
            return state.namedLocation('Welcome');
          } else {
            return null;
          }
        },
        routes: [
          welcomeRouter,
          shellRouter,
        ],
      ),
    );
  }
}
