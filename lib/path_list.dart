import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'data_provider.dart';
import 'data.dart';
import 'card_item.dart';

class PathList extends StatelessWidget {
  const PathList({super.key});

  @override
  Widget build(BuildContext context) {
    final dataStore = DataProvider.of<DataStore>(context);
    return FutureBuilder(
      future: dataStore.findPaths(false),
      builder: (context, snapshot) {
        Widget body;
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          body = ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => CardItem(
              header: snapshot.data![index].name,
              content: snapshot.data![index].description,
              image: snapshot.data![index].image,
              onTap: () => context.goNamed(
                'Course',
                pathParameters: {'id': snapshot.data![index].id.toString()},
              ),
            ),
          );
        } else {
          body = const Center(child: CircularProgressIndicator());
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10,
              ),
              child: Text(
                'What do you want to learn?',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20.0,
                    ),
              ),
            ),
            Expanded(child: body)
          ],
        );
      },
    );
  }
}
