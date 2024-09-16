import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

import 'data_provider.dart';
import 'data.dart';
import 'model.dart';
import 'shell.dart';
import 'path_list.dart';
import 'course_list.dart';
import 'progress_list.dart';
import 'lecture_list.dart';
import 'lecture.dart';
import 'test.dart';
import 'result.dart';
import 'forum.dart';
import 'post.dart';
import 'new_post.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  dir.createSync(recursive: true);
  final dbPath = join(dir.path, 'data.db');
  final db = await databaseFactoryIo.openDatabase(dbPath);
  final dataStore = DataStore(db);
  await dataStore.init();
  runApp(
    DataProvider(
      data: dataStore,
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(context) => MaterialApp.router(
        theme: ThemeData(
          colorScheme: _colorScheme,
        ),
        routerConfig: _router,
      );
}

final _colorScheme = ColorScheme.fromSeed(seedColor: const Color(0xff028090));
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/resource',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        var path = '';
        if (state.fullPath != null) {
          path = state.fullPath!.split('/')[1];
        }
        return Shell(path: path, child: child);
      },
      routes: [
        GoRoute(
          path: '/resource',
          name: 'Resource',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const PathList(),
          routes: [
            GoRoute(
              path: ':id',
              name: 'Course',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) {
                var id = int.parse(state.pathParameters['id']!);
                return CourseList(id: id);
              },
              routes: [
                GoRoute(
                  path: 'test',
                  name: 'Test',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    var id = int.parse(state.pathParameters['id']!);
                    return Test(id: id);
                  },
                ),
                GoRoute(
                  path: 'result',
                  name: 'Result',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    var id = int.parse(state.pathParameters['id']!);
                    return Result(id: id, score: state.extra as int);
                  },
                )
              ],
            ),
          ],
        ),
        GoRoute(
          path: '/progress',
          name: 'Progress',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const ProgressList(),
          routes: [
            GoRoute(
              path: ':id',
              name: 'Lecture',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) {
                int id = int.parse(state.pathParameters['id']!);
                return LectureList(id: id);
              },
              routes: [
                GoRoute(
                  path: ':index',
                  name: 'Learn',
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    int index = int.parse(state.pathParameters['index']!);
                    return Lecture(
                        index: index, source: state.extra as LectureItem);
                  },
                ),
              ],
            )
          ],
        ),
        GoRoute(
          path: '/forum',
          name: 'Forum',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const Forum(),
          routes: [
            GoRoute(
              path: 'post',
              name: 'Post',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) {
                return Post(source: state.extra as PostItem);
              },
            ),
            GoRoute(
              path: 'new',
              name: 'New Post',
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) => const NewPost(),
            ),
          ],
        ),
      ],
    )
  ],
);
