import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'data_provider.dart';
import 'data.dart';
import 'model.dart';

class Test extends StatelessWidget {
  final String id;

  const Test({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final dataStore = DataProvider.of<DataStore>(context);
    return FutureBuilder(
      future: dataStore.findQuestions(id),
      builder: (context, snapshot) {
        var title = '';
        Widget body;
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          title = '${snapshot.data![0].path} Test';
          body = QuestionList(
              questions: snapshot.data!,
              go: (int score) => context.goNamed(
                    'Result',
                    pathParameters: {'id': id.toString()},
                    extra: score,
                  ));
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

class QuestionList extends StatefulWidget {
  final List<QuestionItem> questions;
  final void Function(int) go;

  const QuestionList({super.key, required this.questions, required this.go});

  @override
  State<QuestionList> createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  Map<String, String> right = {};
  Map<String, String> answer = {};

  @override
  void initState() {
    super.initState();
    for (var e in widget.questions) {
      right[e.title] = e.answer;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      itemCount: widget.questions.length + 1,
      itemBuilder: (context, index) {
        if (index == widget.questions.length) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: FilledButton(
                  child: const Text('Finish'),
                  onPressed: () {
                    var score = 0;
                    answer.forEach((k, v) {
                      if (v == right[k]) {
                        score += 10;
                      }
                    });
                    widget.go(score);
                  },
                ),
              ),
            ],
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(child: Text((index + 1).toString())),
                ),
                Expanded(
                  child: Text(
                    widget.questions[index].title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontSize: 16.0),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      widget.questions[index].description,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 15.0),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Image.asset(widget.questions[index].image),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(widget.questions[index].question,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 15.0)),
                  ),
                ),
              ],
            ),
            ...widget.questions[index].choices.map(
              (choice) => RadioListTile(
                title: Text(choice),
                value: choice,
                groupValue: answer[widget.questions[index].title],
                onChanged: (value) {
                  setState(() {
                    answer[widget.questions[index].title] = value!;
                  });
                },
              ),
            )
          ],
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
