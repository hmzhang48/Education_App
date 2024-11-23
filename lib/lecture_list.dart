import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'state.dart';
import 'card_item.dart';

class LectureList extends ConsumerWidget {
  final String id;

  const LectureList({
    super.key,
    required this.id,
  });

  @override
  Widget build(context, ref) {
    final data = ref.watch(LectureNotifierProvider(id));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          switch (data) {
            AsyncData(:final value) => value[0].path,
            AsyncError() => 'Error',
            _ => '',
          },
        ),
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
              data.when(
                data: (value) => ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 20.0, 0.0),
                  itemCount: value.length,
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
                                    content: value[index].description,
                                    image: value[index].image,
                                    onTap: () => context.goNamed(
                                      'Learn',
                                      pathParameters: {
                                        'id': id,
                                        'index': (index + 1).toString(),
                                      },
                                      extra: value[index],
                                    ),
                                  ),
                                  Positioned(
                                    left: 10.0,
                                    bottom: 10.0,
                                    width: (constraints.maxWidth - 20) *
                                        value[index].learningTime /
                                        value[index].totalTime,
                                    height: 5.0,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
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
                              color: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
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
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Please Retry'),
                      duration: const Duration(milliseconds: 1500),
                      width: MediaQuery.of(context).size.width / 4 * 3,
                      padding: const EdgeInsets.all(8.0),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
