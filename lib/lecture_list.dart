import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'data_provider.dart';
import 'data.dart';
import 'card_item.dart';

class LectureList extends StatelessWidget {
  final String id;

  const LectureList({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final dataStore = DataProvider.of<DataStore>(context);
    return FutureBuilder(
      future: dataStore.findLectures(id),
      builder: (context, snapshot) {
        var title = '';
        Widget body;
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          title = snapshot.data![0].path;
          body = ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => LayoutBuilder(
              builder: (context, constraints) => Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  Container(
                    width: constraints.maxWidth,
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: constraints.maxWidth * 0.9,
                      child: LayoutBuilder(
                        builder: (context, constraints) => Stack(
                          children: [
                            CardItem(
                              header: 'Lecture ${index + 1}',
                              content: snapshot.data![index].description,
                              image: snapshot.data![index].image,
                              onTap: () => context.goNamed(
                                'Learn',
                                pathParameters: {
                                  'id': id.toString(),
                                  'index': (index + 1).toString(),
                                },
                                extra: snapshot.data![index],
                              ),
                            ),
                            Positioned(
                              left: 10.0,
                              bottom: 10.0,
                              width: (constraints.maxWidth - 20) *
                                  snapshot.data![index].learningTime /
                                  snapshot.data![index].totalTime,
                              height: 5.0,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    width: 48,
                    height: 48,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.3),
                            offset: Offset(0.0, 1.0),
                            blurRadius: 3.0,
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          (index + 1).toString(),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontSize: 24.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
          body: ConstrainedBox(
            constraints: const BoxConstraints.expand(),
            child: LayoutBuilder(
              builder: (context, constraints) => Stack(
                children: [
                  Positioned(
                    left: 30.0,
                    width: 2,
                    height: constraints.maxHeight,
                    child: const DecoratedBox(
                        decoration: BoxDecoration(color: Colors.grey)),
                  ),
                  body,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
