import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'model.dart';
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

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

final welcomeRouter = GoRoute(
  path: '/welcome',
  name: 'Welcome',
  parentNavigatorKey: rootNavigatorKey,
  builder: (context, state) => const Welcome(),
  routes: [
    GoRoute(
      path: 'sign',
      name: 'Sign',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) {
        return Sign(create: state.uri.queryParameters['create'] == 'true');
      },
    ),
  ],
);
final shellRouter = ShellRoute(
  navigatorKey: shellNavigatorKey,
  builder: (context, state, child) {
    var path = state.fullPath!.split('/')[1];
    return Shell(path: path, child: child);
  },
  routes: [
    resourceRouter,
    progressRouter,
    forumRouter,
    profileRouter,
    settingRouter,
  ],
);
final resourceRouter = GoRoute(
  path: '/resource',
  name: 'Resource',
  parentNavigatorKey: shellNavigatorKey,
  builder: (context, state) => const PathList(),
  routes: [
    GoRoute(
      path: ':id',
      name: 'Course',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) {
        return CourseList(id: state.pathParameters['id']!);
      },
      routes: [
        GoRoute(
          path: 'test',
          name: 'Test',
          parentNavigatorKey: rootNavigatorKey,
          builder: (context, state) {
            return Test(id: state.pathParameters['id']!);
          },
        ),
        GoRoute(
          path: 'result',
          name: 'Result',
          parentNavigatorKey: rootNavigatorKey,
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
final progressRouter = GoRoute(
  path: '/progress',
  name: 'Progress',
  parentNavigatorKey: shellNavigatorKey,
  builder: (context, state) => const ProgressList(),
  routes: [
    GoRoute(
      path: ':id',
      name: 'Lecture',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) {
        return LectureList(id: state.pathParameters['id']!);
      },
      routes: [
        GoRoute(
          path: ':index',
          name: 'Learn',
          parentNavigatorKey: rootNavigatorKey,
          builder: (context, state) {
            int index = int.parse(state.pathParameters['index']!);
            return Lecture(index: index, source: state.extra as LectureItem);
          },
        ),
      ],
    )
  ],
);
final forumRouter = GoRoute(
  path: '/forum',
  name: 'Forum',
  parentNavigatorKey: shellNavigatorKey,
  builder: (context, state) => const Forum(),
  routes: [
    GoRoute(
      path: 'post',
      name: 'Post',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) {
        return Post(source: state.extra as PostItem);
      },
    ),
    GoRoute(
      path: 'new',
      name: 'New Post',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => const NewPost(),
    ),
  ],
);
final profileRouter = GoRoute(
  path: '/profile',
  name: 'Profile',
  parentNavigatorKey: shellNavigatorKey,
  builder: (context, state) => const Profile(),
);
final settingRouter = GoRoute(
  path: '/setting',
  name: 'Setting',
  parentNavigatorKey: shellNavigatorKey,
  builder: (context, state) => const Setting(),
);
