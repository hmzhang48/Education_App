import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'data_provider.dart';
import 'data.dart';
import 'card_item.dart';

class ProgressList extends StatelessWidget {
  const ProgressList({super.key});

  @override
  Widget build(BuildContext context) {
    final dataStore = DataProvider.of<DataStore>(context);
    return FutureBuilder(
      future: dataStore.findPaths(true),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => CardItem(
              header: snapshot.data![index].name,
              content:
                  'Time: ${snapshot.data![index].learningTime ~/ 60} Hours ${snapshot.data![index].learningTime % 60} Minutes\nProgress: ${(snapshot.data![index].learningTime / snapshot.data![index].totalTime * 100).ceil()}%',
              image: snapshot.data![index].image,
              onTap: () => context.goNamed(
                'Lecture',
                pathParameters: {'id': snapshot.data![index].id.toString()},
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
