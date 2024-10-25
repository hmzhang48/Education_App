import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'data_provider.dart';
import 'data.dart';

var title = {
  0: 'Resource',
  1: 'Progress',
  2: 'Forum',
};

class Shell extends StatefulWidget {
  final String? path;
  final Widget child;

  const Shell({
    super.key,
    required this.path,
    required this.child,
  });

  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int _navigationDrawerIndex = 0;
  int _navigationBarIndex = 0;
  final SearchController controller = SearchController();

  @override
  Widget build(context) {
    _navigationBarIndex = switch (widget.path) {
      'resource' => 0,
      'progress' => 1,
      'forum' => 2,
      _ => _navigationBarIndex,
    };
    return Scaffold(
      appBar: switch (_navigationBarIndex) {
        0 || 1 => AppBar(
            title: Center(
              child: Text(title[_navigationBarIndex]!),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.account_circle),
                tooltip: 'User',
                onPressed: () {},
              ),
            ],
          ),
        _ => null,
      },
      drawer: NavigationDrawer(
        selectedIndex: _navigationDrawerIndex,
        onDestinationSelected: (int index) => setState(
          () => _navigationDrawerIndex = index,
        ),
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
            label: Text('Home'),
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
          ),
          const NavigationDrawerDestination(
            label: Text('Setting'),
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
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
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
          ),
          const NavigationDrawerDestination(
            label: Text('badges'),
            icon: Icon(Icons.emoji_events_outlined),
            selectedIcon: Icon(Icons.emoji_events),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Divider(),
          ),
        ],
      ),
      body: widget.child,
      floatingActionButton: switch (_navigationBarIndex) {
        0 => SearchAnchor(
            searchController: controller,
            builder: (context, controller) => FloatingActionButton(
              child: const Icon(Icons.search),
              onPressed: () => controller.openView(),
            ),
            suggestionsBuilder: (context, controller) async {
              final dataStore = DataProvider.of<DataStore>(context);
              final paths = await dataStore.findPaths();
              return paths.map(
                (e) => ListTile(
                  leading: CircleAvatar(
                    child: Text(e.name.substring(0, 1).toUpperCase()),
                  ),
                  title: Text(e.name),
                  subtitle: Text(e.job),
                  onTap: () => setState(
                    () => controller.closeView(e.id.toString()),
                  ),
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
      bottomNavigationBar: NavigationBar(
        selectedIndex: _navigationBarIndex,
        onDestinationSelected: (int index) {
          if (index != _navigationBarIndex) {
            context.goNamed(title[index]!);
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
    );
  }
}
