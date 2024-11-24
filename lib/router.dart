import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'model.dart';
import 'state.dart';
import 'welcome.dart';
import 'shell.dart';
import 'sign.dart';
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
import 'profile.dart';
import 'setting.dart';

GoRouter createRouter(WidgetRef ref) => GoRouter(
      navigatorKey: _rootNavigatorKey,
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
        _welcomeRouter,
        _shellRouter,
      ],
    );

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final _welcomeRouter = GoRoute(
  path: '/welcome',
  name: 'Welcome',
  parentNavigatorKey: _rootNavigatorKey,
  builder: (context, state) => const Welcome(),
  routes: [
    GoRoute(
      path: 'sign',
      name: 'Sign',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        return Sign(create: state.uri.queryParameters['create'] == 'true');
      },
    ),
  ],
);
final _shellRouter = ShellRoute(
  navigatorKey: _shellNavigatorKey,
  builder: (context, state, child) {
    var path = state.fullPath!.split('/')[1];
    return Shell(path: path, child: child);
  },
  routes: [
    _resourceRouter,
    _progressRouter,
    _forumRouter,
    _profileRouter,
    _settingRouter,
  ],
);
final _resourceRouter = GoRoute(
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
        return CourseList(id: state.pathParameters['id']!);
      },
      routes: [
        GoRoute(
          path: 'test',
          name: 'Test',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) {
            return Test(id: state.pathParameters['id']!);
          },
        ),
        GoRoute(
          path: 'result',
          name: 'Result',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) {
            return Result(
              id: state.pathParameters['id']!,
              score: state.extra as int,
            );
          },
        )
      ],
    ),
  ],
);
final _progressRouter = GoRoute(
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
        return LectureList(id: state.pathParameters['id']!);
      },
      routes: [
        GoRoute(
          path: ':index',
          name: 'Learn',
          parentNavigatorKey: _rootNavigatorKey,
          builder: (context, state) {
            int index = int.parse(state.pathParameters['index']!);
            return Lecture(index: index, source: state.extra as LectureItem);
          },
        ),
      ],
    )
  ],
);
final _forumRouter = GoRoute(
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
);
final _profileRouter = GoRoute(
  path: '/profile',
  name: 'Profile',
  parentNavigatorKey: _shellNavigatorKey,
  builder: (context, state) => const Profile(),
);
final _settingRouter = GoRoute(
  path: '/setting',
  name: 'Setting',
  parentNavigatorKey: _shellNavigatorKey,
  builder: (context, state) => const Setting(),
);
