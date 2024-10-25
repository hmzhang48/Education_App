import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'data_provider.dart';
import 'data.dart';

class CourseList extends StatelessWidget {
  final String id;

  const CourseList({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final dataStore = DataProvider.of<DataStore>(context);
    return FutureBuilder(
      future: dataStore.findCourses(id),
      builder: (context, snapshot) {
        var title = '';
        Widget body;
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          title = snapshot.data![0].path;
          body = ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            itemCount: snapshot.data!.length + 1,
            itemBuilder: (context, index) {
              if (index == snapshot.data!.length) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilledButton(
                      child: const Text('Start'),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Before you start...'),
                          content: const Text(
                              'You need to finish a test to evaluate your knowledge level about this subject so that we can provide a personalized learning path for you.'),
                          actions: [
                            TextButton(
                              onPressed: () => context.pop(),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                context.pop();
                                context.goNamed(
                                  'Test',
                                  pathParameters: {'id': id.toString()},
                                );
                              },
                              child: const Text('Continue'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              return ListTile(
                leading: CircleAvatar(
                  child: Text((index + 1).toString()),
                ),
                title: Text(snapshot.data![index].name),
                subtitle: Text(snapshot.data![index].description),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          );
        } else {
          body = const Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert),
                tooltip: 'more',
                onPressed: () {},
              ),
            ],
          ),
          body: body,
        );
      },
    );
  }
}
