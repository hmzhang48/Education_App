import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'data_provider.dart';
import 'data.dart';

class Result extends StatelessWidget {
  final String id;
  final int score;

  const Result({
    super.key,
    required this.id,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    final dataStore = DataProvider.of<DataStore>(context);
    var level = switch (score) {
      < 10 => '1',
      < 20 => '2',
      _ => '10',
    };
    return FutureBuilder(
      future: dataStore.updatePath(id, {'learning': true}),
      builder: (context, snapshot) {
        Widget body;
        if (snapshot.connectionState == ConnectionState.done) {
          body = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text(
                  'Your knowledge level is...',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontSize: 20.0),
                ),
              ),
              ClipOval(
                child: Container(
                  width: 100,
                  height: 100,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  alignment: Alignment.center,
                  child: Text(
                    level,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 50.0),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        'Your personalized learning path is ready.\nLet\'s start learning!',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 16.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              TextButton(
                child: const Text('Next'),
                onPressed: () => context.goNamed('Progress'),
              ),
            ],
          );
        } else {
          body = const Center(child: CircularProgressIndicator());
        }
        return Scaffold(body: body);
      },
    );
  }
}
