import 'package:flutter/material.dart';

import 'data_provider.dart';
import 'data.dart';
import 'group_list.dart';

class Forum extends StatefulWidget {
  const Forum({super.key});

  @override
  State<Forum> createState() => _ForumState();
}

class _ForumState extends State<Forum> {
  final SearchController controller = SearchController();

  @override
  Widget build(BuildContext context) {
    final dataStore = DataProvider.of<DataStore>(context);
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SearchAnchor(
              searchController: controller,
              builder: (context, controller) => SearchBar(
                onTap: () => controller.openView(),
                leading: IconButton(
                  onPressed: Scaffold.of(context).openDrawer,
                  icon: const Icon(Icons.menu),
                ),
                hintText: 'Search',
                trailing: [
                  IconButton(
                    icon: const Icon(Icons.account_circle),
                    tooltip: 'User',
                    onPressed: () {},
                  ),
                ],
              ),
              suggestionsBuilder: (context, controller) async {
                final posts = await dataStore.findPosts();
                return posts.map(
                  (e) => ListTile(
                    leading: CircleAvatar(
                      child: Text(e.title.substring(0, 1).toUpperCase()),
                    ),
                    title: Text(e.title),
                    subtitle: Text(
                      e.content,
                      maxLines: 1,
                    ),
                    onTap: () => setState(
                      () => controller.closeView(e.id.toString()),
                    ),
                  ),
                );
              },
            ),
          ),
          FutureBuilder(
            future: dataStore.findPaths(true),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return GroupList(groups: snapshot.data!);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )
        ],
      ),
    );
  }
}
