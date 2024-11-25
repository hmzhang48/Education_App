import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'state.dart';

final _rootScaffoldKey = GlobalKey<ScaffoldState>();

class Shell extends HookConsumerWidget {
  final String? path;
  final Widget child;

  const Shell({
    super.key,
    required this.path,
    required this.child,
  });

  @override
  Widget build(context, ref) {
    final controller = useSearchController();
    var navigationDrawerIndex = switch (path) {
      'profile' => 1,
      'setting' => 2,
      _ => 0,
    };
    var navigationBarIndex = switch (path) {
      'resource' => 0,
      'progress' => 1,
      'forum' => 2,
      _ => 3,
    };
    return Scaffold(
      key: _rootScaffoldKey,
      appBar: switch (navigationBarIndex) {
        0 || 1 => AppBar(
            title: Center(
              child: Text(
                switch (navigationBarIndex) {
                  0 => 'Resource',
                  1 => 'Progress',
                  2 => 'Forum',
                  _ => ''
                },
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.account_circle),
                tooltip: 'User',
                onPressed: () {
                  context.goNamed('Profile');
                },
              ),
            ],
          ),
        2 => PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SearchAnchor.bar(
                  searchController: controller,
                  barLeading: IconButton(
                    onPressed: _rootScaffoldKey.currentState!.openDrawer,
                    icon: const Icon(Icons.menu),
                  ),
                  barHintText: 'Search',
                  barTrailing: [
                    IconButton(
                      icon: const Icon(Icons.account_circle),
                      tooltip: 'User',
                      onPressed: () {
                        context.goNamed('Profile');
                      },
                    ),
                  ],
                  suggestionsBuilder: (context, controller) async {
                    final value = await ref
                        .read(suggestionNotifierProvider.notifier)
                        .getPosts();
                    return value.map(
                      (e) => ListTile(
                        leading: CircleAvatar(
                          child: Text(e.title.substring(0, 1).toUpperCase()),
                        ),
                        title: Text(e.title),
                        subtitle: Text(
                          e.content,
                          maxLines: 1,
                        ),
                        onTap: () => controller.closeView(e.title.toString()),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        3 => AppBar(
            title: Center(
              child: Text(
                switch (navigationDrawerIndex) {
                  1 => 'Profile',
                  2 => 'Setting',
                  _ => ''
                },
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert),
                tooltip: 'More',
                onPressed: () {},
              ),
            ],
          ),
        _ => null,
      },
      drawer: NavigationDrawer(
        selectedIndex: navigationDrawerIndex,
        onDestinationSelected: (int index) {
          if (index != navigationDrawerIndex) {
            context.goNamed(
              switch (index) {
                0 => 'Resource',
                1 => 'Profile',
                2 => 'Setting',
                _ => '',
              },
            );
            _rootScaffoldKey.currentState!.closeDrawer();
          }
        },
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 25.0,
            ),
            child: Text(
              'Education App',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20.0,
                  ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Divider(),
          ),
          const NavigationDrawerDestination(
            label: Text('Home'),
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 25.0,
            ),
            child: Text(
              'User',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 15.0,
                  ),
            ),
          ),
          const NavigationDrawerDestination(
            label: Text('Profile'),
            icon: Icon(Icons.account_circle_outlined),
            selectedIcon: Icon(Icons.account_circle),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 25.0,
            ),
            child: Text(
              'App',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 15.0,
                  ),
            ),
          ),
          const NavigationDrawerDestination(
            label: Text('Setting'),
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
          ),
        ],
      ),
      body: child,
      floatingActionButton: switch (navigationBarIndex) {
        0 => SearchAnchor(
            searchController: controller,
            builder: (context, controller) => FloatingActionButton(
              child: const Icon(Icons.search),
              onPressed: () => controller.openView(),
            ),
            suggestionsBuilder: (context, controller) async {
              final value = await ref
                  .read(suggestionNotifierProvider.notifier)
                  .getPaths();
              return value.map(
                (e) => ListTile(
                  leading: CircleAvatar(
                    child: Text(e.name.substring(0, 1).toUpperCase()),
                  ),
                  title: Text(e.name),
                  subtitle: Text(e.job),
                  onTap: () => controller.closeView(e.name.toString()),
                ),
              );
            },
          ),
        2 => FloatingActionButton(
            child: const Icon(Icons.post_add_outlined),
            onPressed: () => context.goNamed('New Post'),
          ),
        _ => null,
      },
      bottomNavigationBar: switch (navigationDrawerIndex) {
        0 => NavigationBar(
            selectedIndex: navigationBarIndex,
            onDestinationSelected: (int index) {
              if (index != navigationBarIndex) {
                context.goNamed(
                  switch (index) {
                    0 => 'Resource',
                    1 => 'Progress',
                    2 => 'Forum',
                    _ => ''
                  },
                );
              }
            },
            destinations: const [
              NavigationDestination(
                selectedIcon: Icon(Icons.source),
                icon: Icon(Icons.source_outlined),
                label: 'Resource',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.web_stories),
                icon: Icon(Icons.web_stories_outlined),
                label: 'Progress',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.forum),
                icon: Icon(Icons.forum_outlined),
                label: 'Forum',
              ),
            ],
          ),
        _ => null,
      },
    );
  }
}
